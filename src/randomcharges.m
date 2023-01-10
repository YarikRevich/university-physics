classdef randomcharges < handle
    %CHARGES Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Charges
    end
    
    methods
        function self = randomcharges()
            for i = 1:1
                self.Charges = [self.Charges struct( ...
                    'x', self.getRandomNumberInRange(0, constants.PLOT_SIZE), ...
                    'y', self.getRandomNumberInRange(0, constants.PLOT_SIZE), ...
                    'charge', self.getRandomNumberInRange(-30, 30), ...
                    'mass', self.getRandomNumberInRange(0, 20), ...
                    'vx', self.getRandomNumberInRange(-10, 10), ...
                    'vy', self.getRandomNumberInRange(-10, 10), ...
                    'ax', self.getRandomNumberInRange(-10, 10), ... 
                    'ay', self.getRandomNumberInRange(-10, 10))];
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
                r = sqrt(pow2(x - data.x) + pow2(y - data.y));

                e = constants.K * data.charge / r;
               
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

                disp("X");
                disp((self.Charges(i).vx * constants.DELTA_TIME) + (0.5 * self.Charges(i).ax * pow2(constants.DELTA_TIME)));
                disp("VX");
                disp(self.Charges(i).vx);
                disp("AX");
                disp(self.Charges(i).ax);

                self.Charges(i).x = self.Charges(i).x + (self.Charges(i).vx * constants.DELTA_TIME) + (0.5 * self.Charges(i).ax * pow2(constants.DELTA_TIME));
                self.Charges(i).y = self.Charges(i).y + (self.Charges(i).vy * constants.DELTA_TIME) + (0.5 * self.Charges(i).ay * pow2(constants.DELTA_TIME));

                self.Charges(i).vx = self.Charges(i).vx + (self.Charges(i).ax * constants.DELTA_TIME);
                self.Charges(i).vy = self.Charges(i).vy + (self.Charges(i).ay * constants.DELTA_TIME);

                self.Charges(i).ax = ex * self.Charges(i).charge / self.Charges(i).mass;
                self.Charges(i).ay = ey * self.Charges(i).charge / self.Charges(i).mass;
             end

%             // if the charge is too close to a stationary charge, field_intensity_movable returns Inf for all values
%             // thus why we check only one of them
%             // in that case, we don't want to update the charge's position
%             if intensity.x.is_infinite() {
%                 println!("Kolizja");
%                 movable_charge.collided = true;
%                 movable_charge.should_move = false;
%                 continue;
%             }
        end
    end
end

