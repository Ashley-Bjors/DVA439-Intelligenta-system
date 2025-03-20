clear

startNew = false;
if(startNew)
    %   If you want to start from scratch
    agent = load(".\basicAgent.mat").agent;
    agentMatrix = agent;
    save("agentMatrix.mat","agentMatrix");
else
    %   If you dont want to start from scratch
    agentMatrix = load(".\agentMatrix").agentMatrix;
    agent = agentMatrix(size(agentMatrix,2));
end



trainingIterations = 10;


for i = 1:trainingIterations
    i
    env = createConnect4Env();
    %Trains the newest agent
    agent = mytrain(agent,env, size(agentMatrix,2));
    
    %Saves the new agent
    agentMatrix(size(agentMatrix,2) + 1) = agent;
    save("agentMatrix.mat","agentMatrix");
end

winrate = verifyConnect4()