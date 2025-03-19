function winRate = verifyConnect4()


agentMatrix = load(".\agentMatrix").agentMatrix;
winRate(size(agentMatrix,2),size(agentMatrix,2)) = 0;


for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(i ~= j)
            env = Connect4Env(); % Skapa en instans av spelet
            state = env.reset(); % Starta om spelet
            
    
            while ~env.isDone
                %   get action from agent (Signified as 1)
                move = getAction(agentMatrix(i),state);
                move = cell2mat(move);
                %   Get response from enviroment
                [state, reward, env.isDone] = env.step(move);
                
                if(env.isDone)
                    break;
                end
                
                %   Get action from opponent (Signified as -1)
                move = getAction(agentMatrix(j),state);
                move = cell2mat(move);
                %   Get response from enviroment
                [state, reward, env.isDone] = env.step(move);
                
            end
            env.displayBoard();
           
            winRate(i,j) = env.player; %-1 means the i beat j and a 1 means j beat i
        end
    end
end
performance(size(agentMatrix,2)) = 0;
hold off
figure(1)
for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(winRate(i,j) == -1)
            scatter(i,j,"+","red")
            performance(i) = performance(i) + 1;
            performance(j) = performance(j) - 1;
        end
        if(winRate(i,j) == 1)
            scatter(i,j,"_","blue")
            performance(i) = performance(i) - 1;
            performance(j) = performance(j) + 1;
        end
        hold on
    end
end
xlabel('Agent (+)') 
ylabel('Opponent (\_)') 
title("Wins/losses")
hold off
figure(2)
bar(performance)
title("Summed performance per agent")

result = 0;
for i = 1:size(agentMatrix,2)
    for j = 1:size(agentMatrix,2)
        if(i > j) % If we are in the upper right side
            if(winRate(i,j) > 0)
                result = result + 1;
            end
        else % If we are in the bottom left side
            if(winRate(i,j) < 0)
                result = result + 1;
            end
        end
    end
end
result = result/(size(agentMatrix,2)^2-size(agentMatrix,2));
disp(result)

