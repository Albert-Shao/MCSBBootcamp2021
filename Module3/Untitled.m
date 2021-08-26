X = zeros(1,100)

% Model parameter
r = 0.1;
K = 0.6;

x(1) = 0.2;

for n = 1:100
    
    x(n+1) = x(n)+ r.*(1-x(n)/k).*x(n);
    plot(x, '-ok');
end
