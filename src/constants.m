classdef constants
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant)
        % Delta time is set in seconds
        DELTA_TIME = 0.00000001;

        PLOT_SIZE = 256;
        
        % Each point draw has a pause, thus end user can easily
        % notice all the changes in the graph
        PLOT_PAUSE = 0.05;

        % Conventional K constant used in physics
        K = 9000000000;
    end

end

