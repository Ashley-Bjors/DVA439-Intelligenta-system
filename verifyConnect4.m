function winRate = verifyConnect4()


agentMatrix = load(".\agentMatrix").agentMatrix;
winRate(size(agentMatrix,2):size(agentMatrix,2)) = 0;

triesAgainstSame = 1;
for k = 1:size(agentMatrix,2)
    for i = 1:size(agentMatrix,2)
        for j = 1:triesAgainstSame
            env = Connect4Env(); % Skapa en instans av spelet
            state = env.reset(); % Starta om spelet
            
    
            while ~env.isDone
                %   get action from agent
                move = getAction(agentMatrix(size(agentMatrix,2)),state);
                move = cell2mat(move);
                %   Get response from agent
                [state, reward, env.isDone] = env.step(move);
                
                if(env.isDone)
                    break;
                end
                
                %   Get action from opponent
                move = getAction(agentMatrix(i),state);
                move = cell2mat(move);
                %   Get response from agent
                [state, reward, env.isDone] = env.step(move);
                
            end
            env.displayBoard();
           
            winRate(i) = winRate(i) - env.player/triesAgainstSame;
            
        end
    end
end
