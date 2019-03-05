% parameters
G = 1;
dt = 0.0002;
nskip = 50;
nframe = 10000;
N = 3;

% mass
m = [2, 0.1, 0.1]';

% positions
x = [0, 2, 2.5]';
y = [0, 0, 0]';
z = [0, 0, 0]';

% velocities
u = [0, 0, 0]';
v = [0, 1, 1]';
w = [0, 0, 0]';

% other paramters to be used
q = ones(N, 1);
d = diag(q);
dt2Gm = (dt^2)*G*m;

% change of velocity
dtu = dt*u;
dtv = dt*v;
dtw = dt*w;

% plot
h = plot3(x, y, z, 'bo');
axis([-1.5, 1.5, -1.5, 1.5, -1.5, 1.5]);
axis equal
axis manual
view(3)
drawnow

% update and plot
for nf = 1:nframe
    for ns = 1:nskip
        A = q*x' - x*q';
        B = q*y' - y*q';
        C = q*z' - z*q';
        Rm3 = ((A.^2 + B.^2 + C.^2) + d).^(-1.5);
        dtu = dtu + (A.*Rm3) * dt2Gm;
        dtv = dtv + (B.*Rm3) * dt2Gm;
        dtw = dtw + (C.*Rm3) * dt2Gm;
        x = x + dtu;
        y = y + dtv;
        z = z + dtw;
    end
    set(h, 'xdata', x, 'ydata', y, 'zdata', z)
    axis([-1.5,1.5,-1.5,1.5])
    axis equal
    axis manual
    view(3)
    drawnow
end

