classdef config < handle
    %CONFIG 
    %   Detailed explanation goes here
    
    properties
        outputFiles
        calculationsFileID
        fieldCharacteristicsFileID
    end
    
    methods
        function self = config()
            rmdir('results', 's');
            mkdir results
        end
        
        function [r] = ReadFromInputFile(~)
            [file,path] = uigetfile('*.txt');
            if isequal(file,0)
                error("Your file extension should be txt only");
            else
                fileID = fopen(fullfile(path,file),'r', 'n', 'US-ASCII');
                rawLine = fgetl(fileID);
                numberOfStaticCharges = str2double(rawLine);

                rawLine = fgetl(fileID);
                r = struct('x', cell(1, numberOfStaticCharges), 'y', cell(1, numberOfStaticCharges), 'charge', cell(1, numberOfStaticCharges));

                index = 1;
                while index <= numberOfStaticCharges
                    splitLine = split(rawLine, " ");

                    x = str2double(splitLine{1});
                    y = str2double(splitLine{2});
                    q = str2double(splitLine{3});

                    r(index) = struct('x', x, 'y', y, 'charge', q);

                    rawLine = fgetl(fileID);
                    index = index + 1;
                end
                fclose(fileID);
            end
        end

        function self = CreateOutputFiles(self, numberOfOutputFiles)
            self.outputFiles = containers.Map();

            for i = 1:numberOfOutputFiles
                mkdir(constants.RESULT_FILE, num2str(i))

                self.outputFiles(strcat(num2str(i), "_", "field_characteristics")) = fopen(fullfile(constants.RESULT_FILE, num2str(i), "field_characteristics"), 'W', 'n', 'US-ASCII');
                self.outputFiles(strcat(num2str(i), "_", "calculations")) = fopen(fullfile(constants.RESULT_FILE, num2str(i), "calculations"), 'W', 'n', 'US-ASCII');
            end
        end

        function WriteFieldCharacteristics(self, chargeIndex, x, y, charge, ex, ey, e, v)
             fprintf(self.outputFiles(strcat(num2str(chargeIndex), "_", "field_characteristics")),...
                 "%f %f %.30f %.30f %.30f %.30f %.30f\n", x, y, charge, ex, ey, e, v);
        end

        function WriteCalculations(self, chargeIndex, t, x, y, vx, vy, ax, ay) 
             fprintf(self.outputFiles(strcat(num2str(chargeIndex), "_", "calculations")),...
                 "%.20f %f %f %.30f %.30f %.30f %.30f\n", t, x, y, vx, vy, ax, ay);
        end

        function CloseFiles(self)
            for key = keys(self.outputFiles)
                fclose(self.outputFiles(key{1}));
            end
        end
    end
end

