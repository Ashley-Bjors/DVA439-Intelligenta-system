function [newAgent,trainStats] = mytrain(agent,env)
% [NEWAGENT,TRAINSTATS] = mytrain(AGENT,ENV) train AGENT within ENVIRONMENT
% with the training options specified on the Train tab of the Reinforcement Learning Designer app.
% mytrain returns trained agent NEWAGENT and training statistics TRAINSTATS.

% Reinforcement Learning Toolbox
% Generated on: 14-Mar-2025 13:47:28

%% Create training options
trainOptions = rlTrainingOptions();

%% Make copy of agent
newAgent = copy(agent);

%% Perform training
trainStats = train(newAgent,env,trainOptions);
