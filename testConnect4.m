env = Connect4Env(); % Skapa en instans av spelet
state = env.reset(); % Starta om spelet
env.displayBoard();

while ~env.isDone
    move = input('Ange ett kolumnnummer (1-7): '); % Spelarens input
    [nextState, reward, isDone] = env.step(move);
    env.displayBoard();
    
    if isDone
        disp('Spelet är slut!');
        break;
    end
end
