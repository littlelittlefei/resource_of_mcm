clear, clc
%data
n = 4;
m = 10;
cost1 = [0: m; 1, 0: (m - 1); 2, 1, 0: (m - 2); 3, 2, 1, 0: (m - 3)]';%size = m, 4
cost = [];
for i = 1: m
    cost = [cost, cost1(i, :)];     %size = n * m, 1
end
gam1 = linspace(1.2, 20.2, m);
gam = gam1';     %size = m, 1
weight = 1 - gam / sum(gam);        %size = m, 1
c = weight;
CAP = [100, 200, 60, 500]';      %size = n, 1
DM1 = 21: (20 + m);
DM = DM1';       %size = m, 1
A2 = [];
for i = 1: n;
    A1 = zeros(n * m, 1);
    A1(i: n: n * m) = 1;
    A2 = [A2; A1'];
end
A_sup = A2;     %size = n, m * n;

A4 = [];
for j = 1: m
    A3 = zeros(n * m, 1);
    A3(n * (j - 1) + 1: n * j) = 1;
    A4 = [A4; A3'];
end
A_dem = A4;     %size = m, m * n;    size(A_sup), size(A_dem)
A = [A_sup; A_dem];     %size = (n + m), (n * m)
b = [CAP; DM];         % size = (n + m), 1;   CAP:line  n;   DM:line m;
Aeq = [];
beq = [];
lb = zeros(n * m, 1);
ub = [];
%X=FMINCON(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS)
options=optimset('Algorithm','active-set');
[x, fval] = fmincon('fun_goal', rand(n * m, 1), A, b, Aeq, beq, lb, ub, [], options);
