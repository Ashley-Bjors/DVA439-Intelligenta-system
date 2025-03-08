classdef Connect4Env < handle
    properties
        Rows = 6;
        Columns = 7;
        board;
        player = 1; % 1 eller -1
        isDone = false;
    end
    
    methods
        %Allows testConnect4 to test Connect4Env Code
        function displayBoard(obj)
            clc;
            disp('Nuvarande spelplan:');
            disp(obj.board);
        end

        function obj = Connect4Env()
            obj.reset();
        end
        
        function state = reset(obj)
            obj.board = zeros(obj.Rows, obj.Columns);
            obj.player = 1;
            obj.isDone = false;
            state = obj.getObservation();
        end
        
        function [nextState, reward, isDone] = step(obj, action)
            if obj.isDone
                error("Spelet är redan slut. Anropa reset() innan nästa drag.");
            end
            
            % Kontrollera om draget är giltigt
            [validMove, playAt] = getValidMove(obj.board, action);
            if ~validMove
                %reward = -10; % Straffa ogiltigt drag
                nextState = obj.getObservation();
                isDone = true;
                return;
            end
            
            % Utför draget
            obj.board(playAt(1), playAt(2)) = obj.player;
            isWin = checkWin(obj.board, playAt, obj.player);
            
            % Beräkna belöning
            if isWin
                reward = 10; % Stor belöning vid vinst
                obj.isDone = true;
            else
                reward = 0; % Ingen belöning för neutralt drag
            end
            
            % Byt spelare
            obj.player = -obj.player;
            nextState = obj.getObservation();
            isDone = obj.isDone;
        end
        
        function state = getObservation(obj)
            % Returnerar brädet som en vektor (för RL)
            state = reshape(obj.board, [], 1);
        end
    end
end

function [valid, playAt] = getValidMove(board, move)
    [hight, width] = size(board);
    valid = false;
    playAt = [];

    if move < 1 || move > width
        return;
    end
    
    for i = hight:-1:1
        if board(i, move) == 0
            playAt = [i, move];
            valid = true;
            return;
        end
    end
end

function win = checkWin(board, playAt, player)
    directions = [0 1; 1 0; 1 1; 1 -1]; % Horisontell, vertikal, diagonal \ och diagonal /
    required = 4;
    
    for d = 1:size(directions, 1)
        count = 1;
        for sign = [-1, 1]
            step = 1;
            while true
                row = playAt(1) + step * sign * directions(d, 1);
                col = playAt(2) + step * sign * directions(d, 2);
                if row < 1 || row > size(board, 1) || col < 1 || col > size(board, 2)
                    break;
                end
                if board(row, col) == player
                    count = count + 1;
                    if count >= required
                        win = true;
                        return;
                    end
                else
                    break;
                end
                step = step + 1;
            end
        end
    end
    win = false;
end

