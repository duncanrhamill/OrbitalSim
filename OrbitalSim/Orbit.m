classdef Orbit
    properties
        body % Given name of the orbit
        e % Eccentricity
        a % Semi major axis
        i % Inclination
        o % Longitude of the ascending node
        w % Argument of periapsis
        t % True anomaly
        T % Period of orbit
    end
    methods
        function obj=Orbit(body, e, a, i, o, w, t)
            obj.body = body;
            obj.e = e;
            obj.a = a;
            obj.i = i;
            obj.o = o;
            obj.w = w;
            obj.t = t;
            obj.T = 2*pi*(obj.a^3/obj.body.u)^0.5;
        end
    end
end