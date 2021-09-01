
dAdt =@(A,I,AP,IK) -10*(1-AP)*A+ 10*(AP) + 100*(IK); 
dIdt =@(A,I,AP,IK) -10*(1-IK)*I + 10*IK + 10*AP;
dAPdt =@(A,I,AP,IK) 10*(1-AP)*A-10*(AP) -10*AP;
dIKdt =@(A,I,AP,IK) 10*(1-IK)*I - 10*IK -100*IK

[T, X] = ode45(@(t,x)[dAdt(x(1), x(2), x(3),x(4)),
                      dIdt(x(1), x(2), x(3), x(4)),
                      dAPdt(x(1), x(2), x(3),x(4)),
                      dIKdt(x(1),x(2),x(3),x(4))], [0,2], [0,1,0,0] );

active_ss = zeros(1,6);

for i = 1:6
    K_tot = 10^(i-4)
    
    dAdt =@(A,I,AP,IK) -10*(1-AP)*A+ 10*(AP) + 100*(IK); 
    dIdt =@(A,I,AP,IK) -10*(K_tot-IK)*I + 10*IK + 10*AP;
    dAPdt =@(A,I,AP,IK) 10*(1-AP)*A-10*(AP) -10*AP;
    dIKdt =@(A,I,AP,IK) 10*(K_tot-IK)*I - 10*IK -100*IK;
    
    [T, X] = ode45(@(t,x)[dAdt(x(1), x(2), x(3),x(4)),
                      dIdt(x(1), x(2), x(3), x(4)),
                      dAPdt(x(1), x(2), x(3),x(4)),
                      dIKdt(x(1),x(2),x(3),x(4))], [0,2], [0,100,0,0]);
    active_ss(i) = X(end, 1);
end

figure(1); hold on;
plot((-3:2),active_ss, '-x')
       
