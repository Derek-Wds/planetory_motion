M = 2;

m1 = 0.5;
u1 = 0;
v1 = 0.6;
w1 = 1;
x1 = 0.4;
y1 = 0;
z1 = 0;

m2 = 0.5;
u2 = 0;
v2 = 1;
w2 = 1;
x2 = 0.6;
y2 = 0;
z2 = 0;

G = 1;
clockmax = 5000;
dt = 0.0002;
x1save = zeros(1, clockmax);
y1save = zeros(1, clockmax);
z1save = zeros(1, clockmax);
x2save = zeros(1, clockmax);
y2save = zeros(1, clockmax);
z2save = zeros(1, clockmax);
x = zeros(3,1);
y = zeros(3,1);
z = zeros(3,1);

nfram2 = 1000;
h=plot3(x,y,z,'bo');
axis([-2,2,-2,2,-2,2])
axis equal
axis manual
view(3)
drawnow

for clock = 1:clockmax
    RS1 = sqrt(x1^2+y1^2+z1^2);
    RS2 = sqrt(x2^2+y2^2+z2^2);
    R12 = sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
    u1 = u1 - dt * G * M * x1 / RS1^3 - dt * G * m2 * (x1-x2) / R12^3;
    v1 = v1 - dt * G * M * y1 / RS1^3 - dt * G * m2 * (y1-y2) / R12^3;
    w1 = w1 - dt * G * M * z1 / RS1^3 - dt * G * m2 * (z1-z2) / R12^3;
    u2 = u2 - dt * G * M * x2 / RS2^3 - dt * G * m1 * (x2-x1) / R12^3;
    v2 = v2 - dt * G * M * y2 / RS2^3 - dt * G * m1 * (y2-y1) / R12^3;
    w2 = w2 - dt * G * M * z2 / RS2^3 - dt * G * m2 * (z2-z1) / R12^3;
    x1 = x1 + dt*u1;
    y1 = y1 + dt*v1;
    z1 = z1 + dt*w1;
    x2 = x2 + dt*u2;
    y2 = y2 + dt*v2;
    z2 = z2 + dt*w2;
    x1save(clock) = x1;
    y1save(clock) = y1;
    z1save(clock) = z1;
    x2save(clock) = x2;
    y2save(clock) = y2;
    z2save(clock) = z2;
    x = [0, x1, x2];
    y = [0, y1, y2];
    z = [0, z1, z2];
    set(h,'xdata', x,'ydata', y,'zdata',z)
    axis([-2,2,-2,2,-2,2])
    axis equal
    axis manual
    view(3)
    drawnow
end

    
    