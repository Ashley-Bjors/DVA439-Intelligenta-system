classdef createConnect4Env < rl.env.MATLABEnvironment
    properties
        Rows = 6;
        Columns = 7;
        board
        player = 1; % 1 eller -1
        isDone = false;
    end
    
    methods
        function obj = createConnect4Env()
            % Definiera observation och actions för RL Designer
            obsDim = [7, 6, 1]; % Matchar CNN-input
            observationInfo = rlNumericSpec(obsDim, 'LowerLimit', 0, 'UpperLimit', 1);
            actionInfo = rlFiniteSetSpec(1:7);
            actionInfo.Name = 'Column Selection';

            % Anropa superklassens konstruktor FÖRST
            obj@rl.env.MATLABEnvironment(observationInfo, actionInfo);
            
            % Initiera spelplanen
            obj.reset();
        end
        
        function [nextState, reward, isDone, loggedSignals] = step(obj, action)
            loggedSignals = [];

            if obj.isDone
                error("Spelet är redan slut. Anropa reset() innan nästa drag.");
            end
            
            % Kontrollera om draget är giltigt
            [validMove, playAt] = obj.getValidMove(action);
            if ~validMove
                reward = -10; % Straffa ogiltigt drag
                nextState = obj.getObservation();
                isDone = true;
                return;
            end
            
            % Utför draget
            obj.board(playAt(1), playAt(2)) = obj.player;
            isWin = obj.checkWin(playAt);
            
            % Belöningsfunktion
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
        
        function state = reset(obj)
            obj.board = zeros(obj.Rows, obj.Columns);
            obj.player = 1;
            obj.isDone = false;
            state = obj.getObservation();
        end
        
        function state = getObservation(obj)
            state = reshape(obj.board, [7, 6, 1]); % Anpassar brädet till CNN-input
        end
    end

    methods (Access = private)
        function [valid, playAt] = getValidMove(obj, move)
            valid = false;
            playAt = [];

            if move < 1 || move > obj.Columns
                return;
            end

            for i = obj.Rows:-1:1
                if obj.board(i, move) == 0
                    playAt = [i, move];
                    valid = true;
                    return;
                end
            end
        end

        function win = checkWin(obj, playAt)
            directions = [0 1; 1 0; 1 1; 1 -1]; % Horisontell, vertikal, diagonal \ och /
            required = 4;
            win = false;

            for d = 1:size(directions, 1)
                count = 1;
                for sign = [-1, 1]
                    step = 1;
                    while true
                        row = playAt(1) + step * sign * directions(d, 1);
                        col = playAt(2) + step * sign * directions(d, 2);
                        if row < 1 || row > obj.Rows || col < 1 || col > obj.Columns
                            break;
                        end
                        if obj.board(row, col) == obj.player
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
        end
    end
end
