figure;
hold all;

FPoA = [1 0 0];

Re = 6371e3;
mu = 3.986004418e14;

Pe = 4*Re;
Ap = 270*Re;

e = (Ap - Pe)/(Ap + Pe);

k.a = 0.5*(Pe+Ap);
k.e = e;
k.i = degtorad(0);
k.o = degtorad(90);
k.w = degtorad(60);
k.M0 = degtorad(90);

Tau = 2 * pi * sqrt(k.a^3/mu);

T = 10;
nt = 500;
dt = T/nt;

%{
%Failed attempt at increasing accuracy in the fast sections
m0 = k.M0;
k.M0 = 0;
[rp, Vm] = keptocart(k, 0, mu);
k.M0 = m0;

Vm = sqrt(sum(Vm.^2));
KT = T * pi / (2.1*Vm*sin(pi^2/4.2/Vm));
KTau = Tau * pi / (2.1*Vm*sin(pi^2/4.2/Vm));
dt = KT.*cos(pi/2.1/Vm*linspace(0, T, nt));
dTau = KTau.*cos(pi/2.1/Vm*linspace(0, Tau, nt));
%}

p = [];

disp('Calculating s/c path...');

tic;
lastsize = 0;
for t = nonLinspace(0, Tau, nt, 'cos');
    [r, V] = keptocart(k, t, mu);
    p = [p; r' V'];
    per = 100*t/Tau;
    fprintf(repmat('\b', 1, lastsize));
    lastsize = fprintf('%1.1f%%', per);
end
fprintf('\nCalculation took %fs\n', toc);

ax = gca;
daspect([1 1 1]);
rotate3d on;
[earth_x, earth_y, earth_z] = sphere;
mesh(earth_x*Re, earth_y*Re, earth_z*Re);
plot3(p(:,1), p(:,2), p(:,3), 'b');
view(45, 45);
grid on

sc = animatedline('Color', 'r', 'Marker', 'o');

a = tic;
for i = 1:1:(length(p)-1)
    r = double(p(i,1:3));
    clearpoints(sc);
    addpoints(sc, r(1), r(2), r(3));
    b = toc(a);
    if (b > dt)
        drawnow
        a = tic;
    end
end



