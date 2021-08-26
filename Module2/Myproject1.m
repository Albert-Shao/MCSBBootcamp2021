

nMax = 22; % max number of days to simulate

x = zeros(1, nMax)
N = 10; % number of scoops in each jar
x = zeros(1,nMax); % fraction caffeinated
x(1) = 1.0; % initial fraction caffeinated

for n=2:nMax
    
    x(n) = (1-1/N) * x(n-1);
    %x(n) = x(n-1) - 1/N*x(n-1);
    
end % finished loop through days

% THE MODEL ^
% ------------------------------------------
% THE BEHAVIOR / THE OUTPUT ? 

figure(1); 
plot(x,'-ok');
ylabel('fraction caffeinated')
xlabel('Days')