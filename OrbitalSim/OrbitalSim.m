earth = Body(5.972e24, 6371e3);
orbit = Orbit(earth, 0.8, earth.R + 1000e3, 0, 0, 0, 0);
sc = Spacecraft(earth, orbit, 100, 0);
