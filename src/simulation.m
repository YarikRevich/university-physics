classdef simulation
    %SIMULATION 
    %   
    
    properties(SetAccess = 'private', GetAccess = 'private')
        Config
        RandomCharges
    end
    
    methods
        function self = simulation()
            self.Config = config();
            self.RandomCharges = randomcharges();
        end
           
        function run(self)
            figure('Units', 'pixels');

            inputData = self.Config.readFromInputFile();

            retries = 0;
            while retries < 1000
                hold on
                title('Change of electrical pole');

                xlim([0, constants.PLOT_SIZE]);
                ylim([0, constants.PLOT_SIZE]);

                grid on
                for data  = inputData
                    plot(data.x, data.y, "b*", 'Color', "black", 'MarkerSize', 17);
                end 

%                 hold off
% 
%                 pause(10)
% 
%                 continue

                for charge = self.RandomCharges.Charges
%                     if (charge.x > constants.PLOT_SIZE || charge.y > constants.PLOT_SIZE)
%                         continue
%                     end

                    if (charge.charge > 0)
                        color = "cyan";
                    else
                        color = "magenta";
                    end

%                     display(charge.x);
                    plot(charge.x, charge.y, "b*", 'MarkerSize', 5, 'Color', color)
                end
                hold off
                
                self.RandomCharges.Update(inputData);
                retries = retries + 1;

                pause(0.1)
                clf('reset')
            end
            close
        end

        function [x1, y1, vx1, vy1] = getAdditionalPointData(~, x0, y0, vx0, vy0, ax, ay)
             x1 = x0 + vx0 * constants.DELTA_TIME + 0.5 * ax * pow2(constants.DELTA_TIME);
             y1 = y0 + vy0 * constants.DELTA_TIME + 0.5 * ay * pow2(constants.DELTA_TIME);
             
             vx1 = vx0 + ax * constants.DELTA_TIME;
             vy1 = vy0 + ay * constants.DELTA_TIME;
        end

        function [ax, ay, ex, ey] = getPoint(self, x, y, x0, y0, q)
             ex = self.getPoleX(x, y, x0, y0, q);
             ax = (q * ex) / constants.MASS;

             ey = self.getPoleY(x, y, x0, y0, q);
             ay = (q * ey) / constants.MASS;
        end

        function [ex] = getPoleX(~, x, y, x0, y0, q)
            r = sqrt(pow2(x - x0) + pow2(y - y0));
            ex0 = constants.K * q / r;
            ex = ex0 * (x - x0) / r;
%             ex = constants.K * (q * x) / sqrt(pow2(x) + pow2(y));
        end

        function [ey] = getPoleY(~, x, y, x0, y0, q)
            r = sqrt(pow2(x - x0) + pow2(y - y0));
            ey0 = constants.K * q / r;
            ey = ey0 * (y - y0) / r;
%              ey = constants.K * (q * y) / sqrt(pow2(x) + pow2(y));
        end

        function findPoleAtPoint(~)
        end

        function getMarkerSize(~, q)
            
        end
    end
end

