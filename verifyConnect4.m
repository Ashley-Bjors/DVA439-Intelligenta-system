function [result, winRate, winsPerAgent] = verifyConnect4()


agentMatrix = load(".\agentMatrix").agentMatrix;
winRate(size(agentMatrix,2),size(agentMatrix,2)) = 0;


for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(i ~= j)
            
            env = Connect4Env(); % Skapa en instans av spelet
            state = env.reset(); % Starta om spelet
            
    
            while ~env.isDone
                %   get action from agent
                move = getAction(agentMatrix(j),state);
                move = cell2mat(move);
                %   Get response from enviroment
                [state, reward, env.isDone] = env.step(move);
                
                if(env.isDone)
                    break;
                end
                
                %   Get action from opponent
                move = getAction(agentMatrix(i),state);
                move = cell2mat(move);
                %   Get response from enviroment
                [state, reward, env.isDone] = env.step(move);
                
            end
            %env.displayBoard();
           
            winRate(i,j) = winRate(i,j) - env.player;
                
            
        end
    end
end
result = 0;
for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(i > j)
            if(winRate(i,j) < 0)
                result = result + 1;
            end
        else
            if(winRate(i,j) > 0)
                result = result + 1;
            end
        end
    end
end
result = result/(size(agentMatrix,2)^2-size(agentMatrix,2));

triesAgainstSame = 1000;
winsPerAgent(1:size(agentMatrix,2)) = 0;
for j = 1:size(agentMatrix,2)
    
        for i = 1:triesAgainstSame
            env = Connect4Env(); % Skapa en instans av spelet
            state = env.reset(); % Starta om spelet
            
    
            while ~env.isDone
                %   get action from agent
                move = getAction(agentMatrix(j),state);
                move = cell2mat(move);
                %   Get response from enviroment
                [state, reward, env.isDone] = env.step(move);
                
                if(env.isDone)
                    break;
                end
                
                %   Get action from random opponent
                [state, reward, env.isDone] = env.step(randi(7));
                
            end
            %env.displayBoard();
           
            winsPerAgent(j) = winsPerAgent(j) - env.player/triesAgainstSame;
            
        end
end


winRate
winsPerAgent