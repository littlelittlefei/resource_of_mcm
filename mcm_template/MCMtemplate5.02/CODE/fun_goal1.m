function y_goal = fun_goal(x)
n = 4;
m = 10;
cost1 = [0: m; 1, 0: (m - 1); 2, 1, 0: (m - 2); 3, 2, 1, 0: (m - 3)]';%size = m, n
cost = [];
for i = 1: m
    cost = [cost, cost1(i, :)];     %size = n * m, 1
end
cost = cost';
gam1 = linspace(1.2, 20.2, m);
gam = gam1';     %size = m, 1
weight = 1 - gam / sum(gam);        %size = m, 1
c = weight;
% x_c = x' .* cost;
mu1 = 0.1;
mu2 = 0.9;
y1 = []; y2 = [];
for j = 1: m
    y1 = [y1; sum(x( (n * (j - 1) + 1) : n * j )) .* cost( (n * (j - 1) + 1) : n * j )];        %size = m, 1
    y2 = [y2; sum(x( (n * (j - 1) + 1) : n * j))];      %size = m, 1
end
y2 = DM - y2;
y_nom1 = 1 / (1 - e ^ y1(1: m));    %size = m, 1
y_nom2 = 1 / (1 - e ^ y2(1: m));    %size = m, 1
y_comb = mu1 * y_nom1 + mu2 * y_nom2;
y_goal = sum(c .* y_comb);
end

m = 10, n = 4
gam1 = linspace(1.2, 20.2, m);
gam = gam1';     %size = m, 1
weight = 1 - gam / sum(gam);        %size = m, 1
c = weight;
mu1 = 0.2;  mu2 = 0.8;
DM1 = 21: (20 + m);
DM = DM1';       %size = m, 1
cost1 = [0: m; 1, 0: (m - 1); 2, 1, 0: (m - 2); 3, 2, 1, 0: (m - 3)]';%size = m, n
cost = [];
for i = 1: m
    cost = [cost, cost1(i, :)];     %size = n * m, 1
end
cost = cost';
x = cost + 1;
y1 = []; y2 = [];
for j = 1: m
    y1 = [y1; sum(x( (n * (j - 1) + 1) : n * j ) .* cost( (n * (j - 1) + 1) : n * j ))];        %size = m, 1
    y2 = [y2; sum(x( (n * (j - 1) + 1) : n * j))];      %size = m, 1
end
y2 = DM - y2;
y_nom1 = 1 / (1 - exp(-y1(1: m)));    %size = m, 1
y_nom2 = 1 / (1 - exp(-y2(1: m)));    %size = m, 1
y_comb = mu1 * y_nom1 + mu2 * y_nom2;
y_goal = y_comb * c;
