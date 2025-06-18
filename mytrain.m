function [newAgent,trainStats] = mytrain(agent,env,dataBase)
% [NEWAGENT,TRAINSTATS] = mytrain(AGENT,ENV) train AGENT within ENVIRONMENT
% with the training options specified on the Train tab of the Reinforcement Learning Designer app.
% mytrain returns trained agent NEWAGENT and training statistics TRAINSTATS.

% Reinforcement Learning Toolbox
% Generated on: 14-Mar-2025 13:47:28

%create epsilon decay
ed = 1-0.1^(1/(5*dataBase));
agent.AgentOptions.EpsilonGreedyExploration.EpsilonDecay = ed;

%% Create training options
trainOptions = rlTrainingOptions();
trainOptions.MaxEpisodes = 10*dataBase;
trainOptions.MaxStepsPerEpisode = 50;
trainOptions.Plots = "none"; %Removes plots
%trainOptions.Verbose = 1; %Outputs results into Command Window
%% Make copy of agent
newAgent = copy(agent);

%% Perform training
trainStats = train(newAgent,env,trainOptions);
