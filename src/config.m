classdef config
    %CONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Data
    end
    
    methods
        function obj = config()
            %CONFIG Construct an instance of this class
            %   Detailed explanation goes here

            [file,path] = uigetfile('*.txt');
            if isequal(file,0)
                error("Your file extension should be txt only");
            else
                fileID = fopen(fullfile(path,file),'r', 'n', 'US-ASCII');
                numberOfPoints = fgetl(fileID);
                 if numberOfPoints == -1
                     error("Input file has a wrong structure");
                 end
                 rawLine = fgetl(fileID);
                 while rawLine ~= -1
                    splitLine = split(rawLine, " ");
                    pointX = str2double(splitLine{1});
                    pointY = str2double(splitLine{2});
                    pointCharge = str2double(splitLine{3});
                    
                    obj.Data = [obj.Data struct('pointX', pointX, 'pointY', pointY, 'pointCharge', pointCharge)];

                    rawLine = fgetl(fileID);
                 end
                fclose(fileID);
            end
        end

        function [data] = get.Data(self)
            data = self.Data;
        end
    end
end

