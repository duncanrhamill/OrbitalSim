classdef Body
    properties
        M % mass of the body
        u % gravitational parameter
        R % radius
    end
    methods
        function obj=Body(M, R)
            obj.M = M;
            obj.u = M * 6.67408e-11;
            obj.R = R;
        end
    end
end