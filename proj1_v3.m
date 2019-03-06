M = 16;

m1 = 2;
u1 = 0;
v1 = 1+(1/32)*(sqrt(32.5^2+0.75));
w1 = 0;
x1 = 32.5;
y1 = 0;
z1 = 0.5*sqrt(3);

m2 = 2;
u2 = 0;
v2 = -1+(1/32)*(sqrt(31.5^2+0.75));
w2 = 0;
x2 = 31.5;
y2 = 0;
z2 = -0.5*sqrt(3);

G = 2;
clockmax = 10000;
dt = 0.2;
x1save = zeros(1,clockmax);
y1save = zeros(1,clockmax);
z1save = zeros(1,clockmax);
x2save = zeros(1,clockmax);
y2save = zeros(1,clockmax);
z2save = zeros(1,clockmax);


[X Y Z] = sphere(50);   

tSTAR = imread('star.jpg');
tBINARY1 = imread('binary1.jpg');
tBINARY2 = imread('binary2.jpg');

star = surf(8*X,8*Y,8*Z);
set(star,'facecolor','texture','cdata',im2double(tSTAR),'edgecolor','none');
hold on;
binary1 = surf(x1+0.5*X,y1+0.5*Y,z1+0.5*Z);
set(binary1,'facecolor','texture','cdata',im2double(tBINARY1),'edgecolor','none');

binary2 = surf(x2+0.5*X,y2+0.5*Y,z2+0.5*Z);
set(binary2,'facecolor','texture','cdata',im2double(tBINARY2),'edgecolor','none');

axis([-35 35 -35 35 -35 35]);
axis equal
set(gca,'color','k');
rotate3d;

for clock = 1:clockmax
    RS1 = sqrt(x1^2+y1^2+z1^2);
    RS2 = sqrt(x2^2+y2^2+z2^2);
    R12 = sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
    u1 = u1 - dt * G * M * x1 / ((RS1)^3) - dt * G * m2 * (x1-x2) / R12^3;
    v1 = v1 - dt * G * M * y1 / ((RS1)^3) - dt * G * m2 * (y1-y2) / R12^3;
    w1 = w1 - dt * G * M * z1 / ((RS1)^3) - dt * G * m2 * (z1-z2) / R12^3;
    u2 = u2 - dt * G * M * x2 / ((RS2)^3) - dt * G * m1 * (x2-x1) / R12^3;
    v2 = v2 - dt * G * M * y2 / ((RS2)^3) - dt * G * m1 * (y2-y1) / R12^3;
    w2 = w2 - dt * G * M * z2 / ((RS2)^3) - dt * G * m1 * (z2-z1) / R12^3;
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
    
    plot3(0, 0, 0, x1save, y1save, z1save, '.');
    plot3(0, 0, 0, x2save, y2save, z2save, '.');
    
    rotate(star,[0,0,1],0.02,[0 0 0]);
    
    set(binary1,'xdata',x1 + 0.5*X,...
               'ydata',y1 + 0.5*Y,...
               'zdata',z1 + 0.5*Z);
    rotate(binary1,[0,0,1],0.25,[x1,y1,z1]);

    set(binary2,'xdata',x2 + 0.5*X,...
              'ydata',y2 + 0.5*Y,...
              'zdata',z2 + 0.5*Z);
    rotate(binary2,[0,0,1],0.25,[x2,y2,z2]);
    
    drawnow;
end

    