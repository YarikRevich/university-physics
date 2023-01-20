classdef constants
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant)
        % Delta time is set in seconds
        DELTA_TIME = 0.0000000001;

        % Size of a plot
        PLOT_SIZE = 256;

        % PLOT_SIZE + 1
        OUT_OF_PLOT = 257;
        
        % Each point draw has a pause, thus end user can easily
        % notice all the changes in the graph
        PLOT_PAUSE = 0.001;

        COLLISION_DISTANCE = 2;

        % Conventional K constant used in physics
        K = 9000000000;

        % Result file folder name, which contains all output files
        RESULT_FOLDER = "results";
    end

end

