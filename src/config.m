classdef config
    %CONFIG 
    %   Detailed explanation goes here
    
    properties
        outputFileID
    end
    
    methods

        function self = config()
            self.outputFileID = fopen("./output",'W', 'n', 'US-ASCII');
        end
        

        function [r] = readFromInputFile(~)
            
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

        function writeToOutputFile(self, x, y, vx, vy, ax, ay)
            fprintf(self.outputFileID, "%f %f %f %f %f %f\n", x, y, vx, vy, ax, ay);
        end

        function closeOutputFile(self)
            fclose(self.outputFileID);
        end
    end
end

