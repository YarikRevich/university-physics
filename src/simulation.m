

classdef simulation
    %SIMULATION 
    %   
    
    properties(SetAccess = 'private', GetAccess = 'private')
        Config
    end
    
    methods
        function obj = simulation(config)
            obj.Config = config;
        end
           
        function run(obj)
             
        end
    end
end

