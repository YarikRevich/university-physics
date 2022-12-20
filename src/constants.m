classdef constants
    %CONSTANTS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant)
        START_X = 10;
        START_Y = 10;
        
        % Speed is set in m/s
        START_SPEED_X = 10; 
        START_SPEED_Y = 10;

        % Delta time is set in seconds
        DELTA_TIME = 1;

        % Mass is set in kolograms
        MASS = 2;

        PLOT_SIZE = 256;
        
        % Each point draw has a pause, thus end user can easily
        % notice all the changes in the graph
        PLOT_PAUSE = 0.05;
    end

end

