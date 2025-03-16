clear all

env = createConnect4Env();

%   If you want to start from scratch
agent = load(".\basicAgent.mat").agent;
agentMatrix(1) = agent;
save("agentMatrix.mat","agentMatrix");

%   If you dont want to start from scratch
%agentMatrix = load(".\agentMatrix")
%agent = agentMatrix(size(agentMatrix,2))

for i = 1:3
    %Trains the newest agent
    agent = mytrain(agent,env);
    
    %Saves the new agent
    agentMatrix(size(agentMatrix,2) + 1) = agent;
    save("agentMatrix.mat","agentMatrix");
end