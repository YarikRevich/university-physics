classdef simulation
    %SIMULATION 
    % Contains main simulation pipeline  
    
    properties(SetAccess = 'private', GetAccess = 'private')
        Config
        ChargeManager
    end
    
    methods
        function self = simulation()
            self.Config = config();
            self.ChargeManager = chargemanager();
        end
           
        function run(self)
            format long
            
            inputData = self.Config.ReadFromInputFile();
            self.ChargeManager.SelectCharges();

            if (~self.ChargeManager.Initialized)
                return
            end 

            self.Config.CreateOutputFiles(self.ChargeManager.getNumberOfCharges());

            figure('Units', 'pixels');

            self.ChargeManager.Update(inputData);
            retries = 0;
            numberOfAvailableCharges = self.ChargeManager.GetNumberOfAvailableCharges();
            while retries < 1000 && numberOfAvailableCharges ~= 0
                clf('reset')
                
                hold on
                
                title('Change of electrical pole');

                xlim([0, constants.PLOT_SIZE]);
                ylim([0, constants.PLOT_SIZE]);

                grid on
                for data  = inputData
                    plot(data.x, data.y, "b*", 'Color', "black", 'MarkerSize', 17);
                end 

                for i = 1:length(self.ChargeManager.Charges)
                    if (self.ChargeManager.Charges(i).x > constants.PLOT_SIZE || self.ChargeManager.Charges(i).y > constants.PLOT_SIZE)
                        continue
                    end

                    if (self.ChargeManager.Charges(i).charge > 0)
                        color = "#FF6347";
                    else
                        color = "magenta";
                    end

                    self.Config.WriteFieldCharacteristics(i, self.ChargeManager.Charges(i).x, ...
                        self.ChargeManager.Charges(i).y, ...
                        self.ChargeManager.Charges(i).charge, ...
                        self.ChargeManager.Charges(i).ex, ...
                        self.ChargeManager.Charges(i).ey, ...
                        self.ChargeManager.Charges(i).e, ...
                        self.ChargeManager.Charges(i).v);
                    
                    self.Config.WriteCalculations(i, ...
                        self.ChargeManager.Charges(i).x, ...
                        self.ChargeManager.Charges(i).y, ...
                        self.ChargeManager.Charges(i).vx, ...
                        self.ChargeManager.Charges(i).vy, ...
                        self.ChargeManager.Charges(i).ax, ...
                        self.ChargeManager.Charges(i).ay);
                    plot(self.ChargeManager.Charges(i).x, self.ChargeManager.Charges(i).y, "b*", 'MarkerSize', 5, 'Color', color)
                end
                hold off
                
                self.ChargeManager.Update(inputData);
                retries = retries + 1;
                numberOfAvailableCharges = self.ChargeManager.GetNumberOfAvailableCharges();
                pause(constants.PLOT_PAUSE)
            end
            close
            self.Config.CloseFiles();
        end
    end
end

