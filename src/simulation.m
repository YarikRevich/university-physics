classdef simulation
    %SIMULATION 
    % Contains main simulation pipeline  
    
    properties(SetAccess = 'private', GetAccess = 'private')
        Config
        ChargeManager
        TimeTracker
    end
    
    methods
        function self = simulation()
            self.Config = config();
            self.ChargeManager = chargemanager();
            self.TimeTracker = timetracker();
        end
           
        function run(self)
            format long
            
            inputData = self.Config.ReadFromInputFile();
            self.ChargeManager.SelectCharges();

            if (~self.ChargeManager.Initialized)
                return
            end 

            self.Config.CreateOutputFiles(self.ChargeManager.getNumberOfCharges());

            figure('Units', 'pixels', 'Position', [150, 0, 1000, 1000]);

            self.ChargeManager.Update(inputData);
            iterations = 0;
            numberOfAvailableCharges = self.ChargeManager.GetNumberOfAvailableCharges();
            while iterations < 1000 && numberOfAvailableCharges ~= 0
                clf('reset')
                
                hold on
                
                title('Simulation of charge movement under the influence of an electric field');

                xlim([0, constants.PLOT_SIZE]);
                ylim([0, constants.PLOT_SIZE]);

                grid on
                for data  = inputData
                    plot(data.x, data.y, "b*", 'Color', "black", 'MarkerSize', 21);
                end 

                drawStart = tic;
                for i = 1:length(self.ChargeManager.Charges)
                    if (self.ChargeManager.Charges(i).x < 0 || self.ChargeManager.Charges(i).x > constants.PLOT_SIZE || self.ChargeManager.Charges(i).y < 0 || self.ChargeManager.Charges(i).y > constants.PLOT_SIZE)
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

                    deltaTime = self.TimeTracker.getDeltaTime(i) + self.ChargeManager.Charges(i).lastCalculationTime + toc(drawStart) + constants.PLOT_PAUSE;

                    self.Config.WriteCalculations(i, ...
                        deltaTime , ...
                        self.ChargeManager.Charges(i).x, ...
                        self.ChargeManager.Charges(i).y, ...
                        self.ChargeManager.Charges(i).vx, ...
                        self.ChargeManager.Charges(i).vy, ...
                        self.ChargeManager.Charges(i).ax, ...
                        self.ChargeManager.Charges(i).ay);

                    self.TimeTracker.setDeltaTime(i, deltaTime);

                    plot(self.ChargeManager.Charges(i).x, self.ChargeManager.Charges(i).y, "b*", 'MarkerSize', 11, 'Color', color)
                    text(self.ChargeManager.Charges(i).x, self.ChargeManager.Charges(i).y + 3, num2str(i), 'VerticalAlignment','bottom','HorizontalAlignment','right')
                end
                hold off
                
                self.ChargeManager.Update(inputData);
                iterations = iterations + 1;
                numberOfAvailableCharges = self.ChargeManager.GetNumberOfAvailableCharges();
                pause(constants.PLOT_PAUSE)
            end
            close
            self.Config.CloseFiles();
        end
    end
end

