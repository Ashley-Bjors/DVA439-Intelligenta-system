function winRate = verifyConnect4()


agentMatrix = load(".\agentMatrix").agentMatrix;
winRate(size(agentMatrix,2),size(agentMatrix,2)) = 0;

triesAgainstSame = 1;
for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(i ~= j)
            for k = 1:triesAgainstSame
                env = Connect4Env(); % Skapa en instans av spelet
                state = env.reset(); % Starta om spelet
                
        
                while ~env.isDone
                    %   get action from agent
                    move = getAction(agentMatrix(i),state);
                    move = cell2mat(move);
                    %   Get response from enviroment
                    [state, reward, env.isDone] = env.step(move);
                    
                    if(env.isDone)
                        break;
                    end
                    
                    %   Get action from opponent
                    move = getAction(agentMatrix(j),state);
                    move = cell2mat(move);
                    %   Get response from enviroment
                    [state, reward, env.isDone] = env.step(move);
                    
                end
                env.displayBoard();
               
                winRate(i,j) = winRate(i,j) - env.player/triesAgainstSame;
                
            end
        end
    end
end
result = 0;
for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(i > j)
            result = result + winRate(i,j);
        else
            result = result - winRate(i,j);
        end
    end
end
disp(result)