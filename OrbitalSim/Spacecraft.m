classdef Spacecraft
    properties
        body
        orbit
        t
        m
        r
        v
    end
    methods
        function obj=Spacecraft(body, orbit, t, m)
            obj.body = body;
            obj.orbit = orbit;
            obj.t = t;
            obj.orbit.t = obj.t;
            obj.m = m;
            obj.r = (obj.orbit.a * (1 - obj.orbit.e^2))/(1 + obj.orbit.e * cos(obj.t));
            obj.v = (obj.body.u * (2/obj.r - 1/obj.orbit.a))^0.5;
        end
        function Update(obj)
            obj.t = obj.orbit.t;
            obj.r = (obj.orbit.a * (1 - obj.orbit.e^2))/(1 + obj.orbit.e * cos(obj.t));
            obj.v = (obj.body.u * (2/obj.r - 1/obj.orbit.a))^0.5;
        end
        function Plot(obj)
            ts = 0:0.01:2*pi;
            
        end
    end
    
end