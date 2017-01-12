function  dy = fun_ode1(t, y)
d1 = 1.02e-4; %0.102
d2 = 3.02e-5;   % birth rate;
bet = 0.85;     % propagation coefficient
gam = 1.2e-4;     % removal rate constants from groups I;
cyt = 0.624;     % removal rate constants from groups Q;
det = 0.013;     %rate constant for individuals leaving the infec-
            % -tious compartment and I for the quarantine compartment Q;
arf1 = 0.795;    %extra disease-related death rate constants in class I;
arf2 = 0.0121;    %extra disease-related death rate constants in class Q;
dy = zeros(4, 1); 
% y(1) = I(infected);     y(2) = S(susceptible); 
%y(3) = Q(quarantined);     y(4) = R(recovered);
dy(1) = bet * y(1) * y(2) - (det + gam + d2 + arf1) * y(1);
dy(2) = d1 - ( bet * y(1) + d2 ) * y(2);
dy(3) = det * y(1) - (d2 + arf2 + cyt) * y(3);
dy(4) = gam * y(1) + cyt * y(3) - d2 * y(4);
% s用来衡量疫苗作用的好坏， r用来衡量治愈药物作用的好坏
end