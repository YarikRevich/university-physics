classdef config
    %CONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        outputFileID
    end
    
    methods

        function self = config()
            self.outputFileID = fopen("./output",'W', 'n', 'US-ASCII');
        end
        

        function [r] = readFromInputFile(~)
            r = [];
            [file,path] = uigetfile('*.txt');
            if isequal(file,0)
                error("Your file extension should be txt only");
            else
                fileID = fopen(fullfile(path,file),'r', 'n', 'US-ASCII');
                 rawLine = fgetl(fileID);
                 while rawLine ~= -1
                    splitLine = split(rawLine, " ");
                    x = str2double(splitLine{1});
                    y = str2double(splitLine{2});
                    q = str2double(splitLine{3});
                    
                    r = [r struct('x', x, 'y', y, 'charge', q)];

                    rawLine = fgetl(fileID);
                 end
                fclose(fileID);
                
            end
        end

        function writeToOutputFile(~, x, y, ax, ay, ex, ey)
            fprintf(fileID, "%d %d", 10, 20);
        end
    end
end

