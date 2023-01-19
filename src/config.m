classdef config
    %CONFIG 
    %   Detailed explanation goes here
    
    properties
        calculationsFileID
        fieldCharacteristicsFileID
    end
    
    methods
        function self = config()
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

        function WriteFieldCharacteristics(self, x, y, charge, ex, ey, e, v)
%             self.calculationsFileID = fopen("./calculations",'W', 'n', 'US-ASCII');
%             self.fieldCharacteristicsFileID = fopen("./field_characteristics",'W', 'n', 'US-ASCII');
% 
%             fprintf(self.fieldCharacteristicsFileID, "%f %f %.20f %.20f %.20f %.20f %.20f\n", x, y, charge, ex, ey, e, v);
        end

        function WriteCalculations(self, x, y, vx, vy, ax, ay)
%             self.calculationsFileID = fopen("./calculations",'W', 'n', 'US-ASCII');
%             self.fieldCharacteristicsFileID = fopen("./field_characteristics",'W', 'n', 'US-ASCII');
% 
%             fprintf(self.calculationsFileID, "%f %f %f %f %f %f\n", x, y, vx, vy, ax, ay);
        end

        function CloseFiles(self)
%             fclose(self.calculationsFileID);
%             fclose(self.fieldCharacteristicsFileID);
        end
    end
end

