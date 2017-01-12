close, clear
res = [];
n2 = 0;
p = 0;
k = 7;
tao = k;
ts = [0, tao];
inval = [ 3.417e-4; 1-3.697e-4; 1.417e-6; 1.417e-6];
[T Y] = ode45('fun_ode1', ts, inval);
place = size(Y, 1);
n1 = floor(place / 7);
for count = 1: 7
   n2 = n2 + Y(n1 * count, 1);
end
res = [res; n2]

for m = 2: 40;
    
    place = size(Y, 1);
    inval = [Y(place, 1);  (1 - p) * Y(place, 2); Y(place, 3); ...
        p * Y(place, 2) + Y(place, 4)];
    tao = m * k;
    ts = [tao - k, tao];
    [T Y] = ode45('fun_ode1', ts, inval);
    place = size(Y, 1);
    n1 = floor(place / 7);
    n2 = 0;
    for count = 1: 7
       n2 = n2 + Y(n1 * count, 1);
    end
    res = [res; n2];
end
week = 1: size(res);
num = res * 6348350;
plot(week, num, 'b-^', 'linewidth', 1.5), hold on
grid on
a = 0.6e5;
b = 0.5;
c = 0.7e5;
y1 = [];
for i = 1: size(res)
    y1 = [y1, a - c * b ^ (week(i) * 0.3)];
end
plot(week(1: size(res)), y1(1: size(res)), 'k--', 'linewidth', 1.5)
title('Demand & Supply of Drugs in Sierra Leone', 'fontsize', 12)
xlabel('Time   (weeks)'), ylabel('Number of Drugs')
legend('demmand', 'supply')
