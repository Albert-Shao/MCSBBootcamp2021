% ------------------------------------------------------
A     = 1.1; % fluorescence intensity units
omega = 2.6; % rad/s
A_0   = 0.01;

u=@(t) A*sin(omega*t)+A_0;

tArray = linspace(0,1.6,200);
uArray = u(tArray); % an array of samples of u
% ------------------------------------------------------

% analytical solutions (in real life, we might not know these)
dudtExact      =  A*omega*cos(omega*tArray);
du2dt2Exact    = -A*omega^2*sin(omega*tArray);
du3dt3Exact    = -A*omega^3*cos(omega*tArray);

% Take the sample and add a bit of noise
 uObserved = u(tArray) + (1e-7)*randn(size(tArray));
 
display(uObserved);

% create finite-difference derivatives for first derivative, second derivative and third derivative
dudt   = diff(uObserved)./diff(tArray);
du2dt2 = diff(dudt)./diff(tArray(1:end-1));
du3dt3 = diff(du2dt2)./diff(tArray(1:end-2));

% and plot them
figure;
subplot(3,1,1); hold on;
plot(tArray(1:end-1), dudt);
plot(tArray, dudtExact, '-r');
xlabel('t');
ylabel('dudt');

subplot(3,1,2); hold on;
plot(tArray(1:end-2), du2dt2);
plot(tArray, du2dt2Exact, '-r');
xlabel('t');
ylabel('du2dt2')

subplot(3,1,3); hold on;
plot(tArray(1:end-3), du3dt3);
plot(tArray, du3dt3Exact, '-r');
xlabel('t');
ylabel('du3dt3')

% define ODE and parameters
a_0 = 500; % molecules per hour
a_1 = 0.5; % molecules per hour, per existing molecule of A
b = 4; % 1/hrs
dPdt =@(P) (a_0 + a_1*P) - b*P;

[T, P] = ode45( @(t,x)dPdt(x), [0,2.0], 0);
plot(T,P)
ylabel('Molecules of protein A');
xlabel('Time (hours)');

% parameters
a = 0;
b = 0;
d = 0;
c = 0;

% model equations
f =@(x,y) a*x + b*y; 
g =@(x,y) c*x + d*y;

[T, X] = ode45(@(t,x)[f(x(1),x(2));g(x(1),x(2))], [0,1000], [.1,.1] );

figure; hold on;
set(gca, 'xlim', [-1, 1], 'ylim', [-1, 1])
ylabel('x');
xlabel('y')

xArray = linspace(-1,1,16);
yArray = linspace(-1,1,16);

[xMesh,yMesh] = meshgrid(xArray, yArray);

% the Matlab plot command for a field of arrows is:
quiver(xMesh, yMesh, f(xMesh, yMesh), g(xMesh,yMesh))

plot(X(:,1),X(:,2),'-r')
plot(X(end,1),X(end,2), 'or')
