

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
            title('Change of electrical pole');

            xlim([0, constants.PLOT_SIZE]);
            ylim([0, constants.PLOT_SIZE]);
            grid on
            
            for i  = self.Config.Data
                [pointX, pointY] = self.getPoint(i.pointX, i.pointY, i.pointCharge);
                [startX, startY, startSpeedX, startSpeedY] = self.getAdditionalPointData(i.pointX, i.pointY, constants.START_SPEED_X, constants.START_SPEED_Y, pointX, pointY);
                retries = 0; 
                while (pointX <= constants.PLOT_SIZE && pointY <= constants.PLOT_SIZE) && retries < 10
                     plot(pointX, pointY,'r*')
                     
                     disp(retries);
                     [pointX, pointY] = self.getPoint(startX, startY, i.pointCharge);
                     [startX, startY, startSpeedX, startSpeedY] = self.getAdditionalPointData(startX, startY, startSpeedX, startSpeedY, pointX, pointY);

                     retries = retries + 1;
                end
                pause(constants.PLOT_PAUSE);
            end
        end

        function [startX, startY, startSpeedX, startSpeedY] = getAdditionalPointData(~, prevStartX, prevStartY, prevStartSpeedX, prevStartSpeedY, prevPointX, prevPointY)
             startX = prevStartX + prevStartSpeedX * constants.DELTA_TIME+ 0.5 * prevPointX * pow2(constants.DELTA_TIME);
             startY = prevStartY + prevStartSpeedY * constants.DELTA_TIME+ 0.5 * prevPointY * pow2(constants.DELTA_TIME);
             startSpeedX = prevStartSpeedX + prevPointX * constants.DELTA_TIME;
             startSpeedY = prevStartSpeedY + prevPointY * constants.DELTA_TIME;
        end

        function [pointX, pointY] = getPoint(self, startX, startY, charge)
             pointX = (charge * self.getPoleEnergyX(startX, startY)) / constants.MASS;
             pointY = (charge * self.getPoleEnergyY(startX, startY)) / constants.MASS; 
        end

        function [result] = getPoleEnergyX(~, startX, startY)
            % Ask teacher, how to calculate this function
            result = 1
        end

        function [result] = getPoleEnergyY(~, startX, startY)
            % Ask teacher, how to calculate this function
            result = 1
        end
    end
end

