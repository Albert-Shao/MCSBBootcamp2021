x = zeros(1,200);

% Model parameter
r = 2.5;
K = 0.6;

x(1) = 0.2;

for n = 1:200
    
    x(n+1) = x(n)+ r.*(1-x(n)/K).*x(n);
    plot(x, '-ok');
end

figure(1);
hold on

for r=0:0.2:0.3
    
    for n=1:200
        x(n+1) = x(n) + r.*(1-x(n)/K).*x(n);
        if n > 100
            plot(r, x(n), '-ok')
            hold on
        end
    end
end
    

                                                                    