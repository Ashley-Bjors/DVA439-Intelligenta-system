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
            obsDim = [6*7, 1]; % Platt representation
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
            [validMove, playAt] = getValidMove(obj.board, action);
            if ~validMove
                reward = -10; % Straffa ogiltigt drag
                nextState = obj.getObservation();
                isDone = true;
                return;
            end
            
            % Utför draget
            obj.board(playAt(1), playAt(2)) = obj.player;
            isWin = checkWin(obj.board, playAt, obj.player);
            
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
            state = reshape(obj.board, [], 1);
        end
    end
end
