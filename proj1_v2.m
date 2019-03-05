M = 16

m1 = 2
u1 = 0
v1 = 2.03125
x1 = 33
y1 = 0

m2 = 2
u2 = 0
v2 = -0.03125
x2 = 31
y2 = 0

G = 2 
clockmax = 10000
dt = 0.2
x1save = zeros(1, clockmax)
y1save = zeros(1, clockmax)
x2save = zeros(1, clockmax)
y2save = zeros(1, clockmax)
x = zeros(3,1)
y = zeros(3,1)

three_body = figure('Name','Three-body problem',... % Figure winndow with specified
               'NumberTitle','off',...       % properties
               'Menubar','none',...
               'Color',[0 0 0]);

h=plot(x,y,'bo')
axis([-40,40,-40,40])
view(2)
drawnow

for clock = 1:clockmax
    RS1 = sqrt(x1^2+y1^2);
    RS2 = sqrt(x2^2+y2^2);
    R12 = sqrt((x1-x2)^2+(y1-y2)^2);
    u1 = u1 - dt * G * M * x1 / ((RS1)^3) - dt * G * m2 * (x1-x2) / R12^3;
    v1 = v1 - dt * G * M * y1 / ((RS1)^3) - dt * G * m2 * (y1-y2) / R12^3;
    u2 = u2 - dt * G * M * x2 / ((RS2)^3) - dt * G * m1 * (x2-x1) / R12^3;
    v2 = v2 - dt * G * M * y2 / ((RS2)^3) - dt * G * m1 * (y2-y1) / R12^3;
    x1 = x1 + dt*u1;
    y1 = y1 + dt*v1;
    x2 = x2 + dt*u2;
    y2 = y2 + dt*v2;
    x1save(clock) = x1;
    y1save(clock) = y1;
    x2save(clock) = x2;
    y2save(clock) = y2;   
    x = [0, x1, x2];
    y = [0, y1, y2];
    set(h,'xdata', x,'ydata', y)
    axis([-40,40,-40,40])
    view()
    drawnow
end

    
    