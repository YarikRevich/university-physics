classdef config
    %CONFIG Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
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
                 point = fgetl(fileID);
                 while point ~= -1
                    disp(point);
                    point = fgetl(fileID);
                 end
                fclose(fileID);
            end
        end
        
        function outputArg = getConfig(obj,inputArg)
            
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end

    end
end

