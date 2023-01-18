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

            figure('Units', 'pixels');

            self.ChargeManager.Update(inputData);
            retries = 0;
            while retries < 1000 && self.ChargeManager.GetNumberOfAvailableCharges() ~= 0
                clf('reset')
                
                hold on
                
                title('Change of electrical pole');

                xlim([0, constants.PLOT_SIZE]);
                ylim([0, constants.PLOT_SIZE]);

                grid on
                for data  = inputData
                    plot(data.x, data.y, "b*", 'Color', "black", 'MarkerSize', 17);
                end 

                for charge = self.ChargeManager.Charges
                    if (charge.x > constants.PLOT_SIZE || charge.y > constants.PLOT_SIZE)
                        continue
                    end

                    if (charge.charge > 0)
                        color = "#FF6347";
                    else
                        color = "magenta";
                    end

                    self.Config.WriteFieldCharacteristics(charge.x, charge.y, charge.charge, charge.ex, charge.ey, charge.e, charge.v);
                    self.Config.WriteCalculations(charge.x, charge.y, charge.vx, charge.vy, charge.ax, charge.ay);
                    plot(charge.x, charge.y, "b*", 'MarkerSize', 5, 'Color', color)
                end
                hold off
                
                self.ChargeManager.Update(inputData);
                retries = retries + 1;
                pause(constants.PLOT_PAUSE)
            end
            close
            self.Config.CloseFiles();
        end
    end
end

