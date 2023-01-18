classdef chargemanager < handle
    %RANDOMCHARGES A manager for charges
    %   Used as a part of a simulation pipeline
    %   as a wrapper for random charges, which makes
    %   it easier to modify and list previously generated charges. 
    
    properties
        Charges
        Initialized
    end

    properties(GetAccess=private, SetAccess=private)
        selectionWindow
    end
    
    methods

        % Creates a new charge using the data given by user using UI
        function setOwnTestCharge(self, ~, ~)
            prompt = {'X: ', 'Y: ', 'VX: ', 'VY: ', 'Charge: ', 'Mass: '};
            dlgtitle = 'Input';
            dims = [1, 35];
            definput = {
                num2str(self.getRandomNumberInRange(0, constants.PLOT_SIZE)), ...
                num2str(self.getRandomNumberInRange(0, constants.PLOT_SIZE)), ...
                num2str(299792458), ...
                num2str(299792458), ...
                num2str(self.getRandomNumberInRange(-1.6022*10^-9, 4.8*10^-5)), ...
                num2str(self.getRandomNumberInRange(9.101*10^-31, 1.64*10^-27)), ...
            };
            answer = inputdlg(prompt,dlgtitle,dims,definput);

            self.Charges = [self.Charges struct( ...
                    'x', str2double(answer{1}), ...
                    'y', str2double(answer{2}), ...
                    'vx', str2double(answer{3}), ...
                    'vy', str2double(answer{4}), ...
                    'charge', str2double(answer{5}), ...
                    'mass', str2double(answer{6}), ...
                    'ax', 0, ... 
                    'ay', 0, ...
                    'e', 0,...
                    'ex', 0, ...
                    'ey', 0, ...
                    'v', 0)];

            self.Initialized = true;
            close(self.selectionWindow);
        end

        % Generates a set of random charges, which
        % amount is set by UI
        function generateRandomCharges(self, ~, ~)
            prompt = {'Enter number of charges to be generated:'};
            dlgtitle = 'Input';
            dims = [1, 35];
            definput = {'30'};
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            
            for i = 1:str2double(answer)
                self.Charges = [self.Charges struct( ...
                    'x', self.getRandomNumberInRange(0, constants.PLOT_SIZE), ...
                    'y', self.getRandomNumberInRange(0, constants.PLOT_SIZE), ...
                    'charge', self.getRandomNumberInRange(-9.6022*10^-5, 4.8*10^-5), ...
                    'mass', self.getRandomNumberInRange(9.101*10^-31, 1.64*10^-27), ...
                    'vx', 299792458, ...
                    'vy', 299792458, ...
                    'ax', 0, ... 
                    'ay', 0, ...
                    'e', 0,...
                    'ex', 0, ...
                    'ey', 0, ...
                    'v', 0)];
            end
            self.Initialized = true;
            close(self.selectionWindow);
        end

        function SelectCharges(self)
            self.selectionWindow = figure();
            drawnow;
            uicontrol("Style", "pushbutton", 'FontSize', 16, "Position", [80, 210, 170, 50], "String", "Set own test charge", "Callback", @self.setOwnTestCharge);
            uicontrol("Style", "pushbutton", 'FontSize', 16, "Position", [310, 210, 210, 50], "String", "Generate random charges", "Callback", @self.generateRandomCharges);
            waitfor(self.selectionWindow);
        end

        function [r] = get.Charges(self)
                r = self.Charges;
        end 

        function [r] = getRandomNumberInRange(~, min, max)
                r = (max-min).*rand(1,1) + min;
        end

        function [e, ex, ey, v] = getFieldCharacteristicsAt(~, x, y, inputData)
            e = 0;
            ex = 0;
            ey = 0;
            v = 0;
            for data = inputData
                e = constants.K * data.charge / (((x - data.x) ^ 2) + ((y - data.y) ^ 2));
                r = sqrt(((x - data.x) ^ 2) + ((y - data.y) ^ 2));
                ex = ex + (e * (x - data.x) / r);
                ey = ey + (e * (y - data.y) / r);
                v = v + (e / r);
            end
        end

        function [r] = GetNumberOfAvailableCharges(self)
            r = 0;
            for i = 1:length(self.Charges)
                if (self.Charges(i).x < constants.PLOT_SIZE && self.Charges(i).y < constants.PLOT_SIZE)
                    r = r + 1;
                end
            end
            
        end 
 
        function Update(self, inputData)
             for i = 1:length(self.Charges)
                [e, ex, ey, v] = self.getFieldCharacteristicsAt(self.Charges(i).x, self.Charges(i).y, inputData);
                if ((ex == Inf || ex == -Inf) || (ey == Inf || ey == -Inf))
                        continue
                end

                self.Charges(i).x = self.Charges(i).x + (self.Charges(i).vx * constants.DELTA_TIME) + (0.5 * self.Charges(i).ax * ((constants.DELTA_TIME) ^ 2));
                self.Charges(i).y = self.Charges(i).y + (self.Charges(i).vy * constants.DELTA_TIME) + (0.5 * self.Charges(i).ay * ((constants.DELTA_TIME) ^ 2));

                self.Charges(i).vx = self.Charges(i).vx + (self.Charges(i).ax * constants.DELTA_TIME);
                self.Charges(i).vy = self.Charges(i).vy + (self.Charges(i).ay * constants.DELTA_TIME);

                self.Charges(i).ax = ex * self.Charges(i).charge / self.Charges(i).mass;
                self.Charges(i).ay = ey * self.Charges(i).charge / self.Charges(i).mass;

                self.Charges(i).e = e;
                self.Charges(i).ex = ex;
                self.Charges(i).ey = ey;
                self.Charges(i).v = v;

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

