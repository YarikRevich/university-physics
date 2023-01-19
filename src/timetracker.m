classdef timetracker < handle
    %TIMETRACKER A class which is used for time tracking during the
    %   executinon
    % Saves in a map delta time calculated with a help of timers
    
    properties
        storage
    end
    
    methods
        function self = timetracker()
            self.storage = containers.Map();
        end

        function setDeltaTime(self, key, value)
            self.storage(num2str(key)) = value;
        end 

        function [r] = getDeltaTime(self, key)
            r = 0;
            if (isKey(self.storage, num2str(key)))
                r = self.storage(num2str(key));
            end
        end
    end
end

