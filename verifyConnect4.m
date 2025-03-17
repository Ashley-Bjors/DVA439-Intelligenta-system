function winRate = verifyConnect4()


agentMatrix = load(".\agentMatrix").agentMatrix;
winRate(1:size(agentMatrix,2)) = 0;

triesAgainstSame = 10;

for i = 1:size(agentMatrix,2)
    for j = 1:triesAgainstSame
        env = Connect4Env(); % Skapa en instans av spelet
        state = env.reset(); % Starta om spelet
        

        while ~env.isDone
            %   Get action from opponent
            move = getAction(agentMatrix(i),state);
            move = cell2mat(move);
            %   Get response from agent
            [state, reward, env.isDone] = env.step(move);
        end
       
        winRate(i) = winRate(i) - env.player/triesAgainstSame;
        
    end
end
