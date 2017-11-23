function [r, V] = keptocart(kep, t, mu)
%KEPTOCART Convert keplerian orbital elements into cartesian state vectors
%   kep should be a stuct containing a, e, i, w, o, v

    if (t == 0)
        Mt = kep.M0;
    elseif (t > 0)
        Mt = kep.M0 + t * sqrt(mu/kep.a^3);
    else
        Mt = kep.M0 - t * sqrt(mu/kep.a^3);
    end
        
    syms E;
    Et = vpasolve(vpa(Mt == E - kep.e*sin(E)), E);
    vt = 2 * atan2(sqrt(1 + kep.e)*sin(Et/2), sqrt(1 - kep.e)*cos(Et/2));
    rc = kep.a*(1 - kep.e*cos(Et));
    
    o = rc.*[cos(vt) sin(vt) 0]';
    odot = sqrt(mu * kep.a)/rc.*[-sin(Et) sqrt(1-kep.e^2)*cos(Et) 0]';
    
    Rx = @(th) [1 0 0; 0 cos(th) -sin(th); 0 sin(th) cos(th)];
    Rz = @(th) [cos(th) -sin(th) 0; sin(th) cos(th) 0; 0 0 1];
    
    r = Rz(-kep.o)*Rx(-kep.i)*Rz(-kep.w)*o;
    V = Rz(-kep.o)*Rx(-kep.i)*Rz(-kep.w)*odot;
end

