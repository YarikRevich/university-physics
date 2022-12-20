

classdef simulation
    %SIMULATION 
    %   
    
    properties(SetAccess = 'private', GetAccess = 'private')
        Config
    end
    
    methods
        function self = simulation(config)
            self.Config = config;
        end
           
        function run(self)
            figure('Units', 'pixels')
            hold on
            
            [pointX, pointY] = self.getPoint(constants.START_X, constants.START_Y);
            [startX, startY, startSpeedX, startSpeedY] = self.getAdditionalPointData(constants.START_X, constants.START_Y, constants.START_SPEED_X. constants.START_SPEED_Y, pointX, pointY);
            while pointX <= constants.PLOT_SIZE && pointY <= constants.PLOT_SIZE
                 plot(rand(256, 0),'r')
                 pause(constants.PLOT_PAUSE);
                  
                 [pointX, pointY] = self.getPoint(startX, startY);
                 [startX, startY, startSpeedX, startSpeedY] = self.getAdditionalPointData(startX, startY, startSpeedX, startSpeedY, pointX, pointY);
            end
            
            title('Hydrogen usage');
            xlim([0, constants.PLOT_SIZE]);
            ylim([0, constants.PLOT_SIZE]);
            grid on
        end

        function [startX, startY, startSpeedX, startSpeedY] = getAdditionalPointData(prevStartX, prevStartY, prevStartSpeedX, prevStartSpeedY, prevPointX, prevPointY)
            startX = prevStartX + prevStartSpeedX * constants.DELTA_TIME+ 0.5 * prevPointX * pow2(constants.DELTA_TIME);
            startY = prevStartY + prevStartSpeedY * constants.DELTA_TIME+ 0.5 * prevPointY * pow2(constants.DELTA_TIME);
            startSpeedX = prevSpeedX + prevPointX * constant.DELTA_TIME;
            startSpeedY = prevSpeedY + prevPointY * constant.DELTA_TIME;
        end

        function [pointX, pointY] = getPoint(self, startX, startY, charge)
             pointX = (charge * self.getPoleEnergyX(startX, startY)) / constants.MASS;
             pointY = (charge * self.getPoleEnergyY(startX, startY)) / constants.MASS; 
        end

        function [result] = getPoleEnergyX(self, startX, startY)
            % Ask teacher, how to calculate this function
        end

        function [result] = getPoleEnergyY(self, startX, startY)
            % Ask teacher, how to calculate this function
        end
    end
end

