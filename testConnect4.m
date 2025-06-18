env = Connect4Env(); % Skapa en instans av spelet
state = env.reset(); % Starta om spelet
env.displayBoard();


agentMatrix = load(".\agentMatrix").agentMatrix;
agent = agentMatrix(size(agentMatrix),1);

whoIsFirst = 1;
if(whoIsFirst == 1)
    whoIsFirst = 1;
else
    whoIsFirst = -1;
end
playAgainstAgent = 1;
playAgain = 1;
while playAgain
    env = Connect4Env(); % Skapa en instans av spelet
    state = env.reset(); % Starta om spelet
    env.displayBoard();
    while ~env.isDone
        if(env.player*whoIsFirst == 1 || playAgainstAgent == 0)
            move = input('Ange ett kolumnnummer (1-7): '); % Spelarens input
        else
            move = getAction(agent,state);
            move = cell2mat(move);
        end
        [state, reward, env.isDone] = env.step(move);
        env.displayBoard();
        
        if env.isDone
            disp('Spelet är slut!');
            break;
        end
    end
    playAgain = input("Ange 1 för att spela igen och ett annat nummer för att sluta: ");
end