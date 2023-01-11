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
            format long
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

                for charge = self.RandomCharges.Charges
                    if (charge.x > constants.PLOT_SIZE || charge.y > constants.PLOT_SIZE)
                        continue
                    end

                    if (charge.charge > 0)
                        color = "#FF6347";
                    else
                        color = "magenta";
                    end

                    plot(charge.x, charge.y, "b*", 'MarkerSize', 5, 'Color', color)
                end
                hold off
                
                self.RandomCharges.Update(inputData);
                retries = retries + 1;
                pause(0.001)
                clf('reset')
            end
            close
        end
    end
end

