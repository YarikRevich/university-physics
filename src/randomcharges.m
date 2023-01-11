classdef randomcharges < handle
    %RANDOMCHARGES Wrapper for random charges
    %   Used as a part of a simulation pipeline
    %   as a wrapper for random charges, which makes
    %   it easier to modify and list previously generated charges. 
    
    properties
        Charges
    end
    
    methods
        function self = randomcharges()
            for i = 1:100
                self.Charges = [self.Charges struct( ...
                    'x', self.getRandomNumberInRange(0, constants.PLOT_SIZE), ...
                    'y', self.getRandomNumberInRange(0, constants.PLOT_SIZE), ...
                    'charge', self.getRandomNumberInRange(-10, 10), ...
                    'mass', self.getRandomNumberInRange(0, 30), ...
                    'vx', self.getRandomNumberInRange(-5, 20), ...
                    'vy', self.getRandomNumberInRange(-5, 20), ...
                    'ax', self.getRandomNumberInRange(-5, 20), ... 
                    'ay', self.getRandomNumberInRange(-5, 20))];
            end
            disp(self.Charges);
        end

        function [r] = get.Charges(self)
                r = self.Charges;
        end 

        function [r] = getRandomNumberInRange(~, min, max)
                r = (max-min).*rand(1,1) + min;
        end

        function [ex, ey] = getPole(~, x, y, inputData)
            ex = 0;
            ey = 0;
            for data = inputData
                e = constants.K * data.charge / (((x - data.x) ^ 2) + ((y - data.y) ^ 2));
                r = sqrt(((x - data.x) ^ 2) + ((y - data.y) ^ 2));
                ex = ex + (e * (x - data.x) / r);
                ey = ey + (e * (y - data.y) / r);
            end

        end

        function Update(self, inputData)
             for i = 1:length(self.Charges)
                [ex, ey] = self.getPole(self.Charges(i).x, self.Charges(i).y, inputData);
                if ((ex == Inf || ex == -Inf) || (ey == Inf || ey == -Inf))
                        continue
                end

                self.Charges(i).x = self.Charges(i).x + (self.Charges(i).vx * constants.DELTA_TIME) + (0.5 * self.Charges(i).ax * ((constants.DELTA_TIME) ^ 2));
                self.Charges(i).y = self.Charges(i).y + (self.Charges(i).vy * constants.DELTA_TIME) + (0.5 * self.Charges(i).ay * ((constants.DELTA_TIME) ^ 2));

                self.Charges(i).vx = self.Charges(i).vx + (self.Charges(i).ax * constants.DELTA_TIME);
                self.Charges(i).vy = self.Charges(i).vy + (self.Charges(i).ay * constants.DELTA_TIME);

                self.Charges(i).ax = ex * self.Charges(i).charge / self.Charges(i).mass;
                self.Charges(i).ay = ey * self.Charges(i).charge / self.Charges(i).mass;

                for data = inputData
                    if (abs(self.Charges(i).x - data.x) < 3 && abs(self.Charges(i).y - data.y) < 3)
                        self.Charges(i).x = constants.OUT_OF_PLOT;
                        self.Charges(i).y = constants.OUT_OF_PLOT;
                    end
                end
             end
        end
    end
end

