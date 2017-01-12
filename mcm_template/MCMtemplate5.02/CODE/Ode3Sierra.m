figure, clear, clc
p = 0;
k = 7;
tao = k;
ts = [0, tao];
inval = [ 1.417e-5; 1-1.697e-5; 1.417e-6; 1.417e-6];
[T Y] = ode45('fun_ode1', ts, inval); 
plot(T, Y(:, 1), 'r-', T, Y(:, 2), 'b-', T, Y(:, 3), 'y-', T, Y(:, 4),'g', ...
    'linewidth', 1.5)
hold on
for m = 2: 40;
    place = size(Y, 1);
    inval = [Y(place, 1);  (1 - p) * Y(place, 2); Y(place, 3); ...
        p * Y(place, 2) + Y(place, 4)];
    tao = m * k;
    ts = [tao - k, tao];
    [T Y] = ode45('fun_ode1', ts, inval);
    size(Y)
    plot(T, Y(:, 1), 'r-', T, Y(:, 2), 'b-', T, Y(:, 3), 'y-', T, Y(:, 4),'g', ...
        'linewidth', 1.5)
    hold on
end
axis([0 tao 0 1])
grid on
legend('infected', 'susceptible', 'quarantined', 'recovered', 'location', 'northwest')
xlabel('Time  (days)'), ylabel('Rate')
title('SIQR Model', 'fontsize', 12)

set(gca,'yscale','log')