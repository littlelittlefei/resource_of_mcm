clear, close, clc
%data
jud = [0.35, 0.15, 0.25, 0.25];
FF = [488	1125    19	583	255	151	480	308	1751	53	539	1437	2669	716
89.107	82.712	93.715	88.544	107.938	35.883	98.915	48.620	114.380	67.751	24.094	484.594	80068.308	81.635
1	0	1	0	0	1	1	0	0	0	0	0	2	1
1	1	0	1	0	0	0	1	0	0	1	8	4	1 ];
% number of infected
% population density
% number of airports
% number of treatment
min1 = min(FF(1, :)); max1 = max(FF(1, :));
a = 50; b = 500;
min3 = min(FF(3, :)); max3 = max(FF(3, :));
min4 = min(FF(4, :)); max4 = max(FF(4, :));
mf = @(x) [( x(1, :) - min1) / (max1 - min1)    %calculate the fuzzy matrix
    (x(2, :) >= b) + (x(2, :) > a & x(2, :) < b).*(x(2, :) - a) / (b - a)
    ( x(3, :) - min3) / (max3 - min3)
    ( x(4, :) - min4) / (max4 - min4)];
norm = mf(FF);
res = jud * norm;
t = 1: 1: 14;
h1 = plot(t, norm(1, :), 'r-*', t, norm(2, :), 'y-+', t, norm(3, :), 'g-o', ...
    t, norm(4, :), 'k-d'), hold on
set(h1(1: 4), 'linewidth', 1.5)
h = bar(res,'barwidth', 0.5)
axis([0 15 0 1])
%title('Priority of Districts in Sierra Leone', 'fontsize', 12)
xlabel('Districts', 'fontsize', 10)
ylabel('Facets & Priorities', 'fontsize', 10)
legend('disease cases', 'population desity', 'airports', 'treatment centers', 'priosity', ...
    'location', 'northwest')
set(gca, 'xtick', [1: 14])
%set(gca, 'XTickLabel', {'BO', 'BOMBALI', 'BONTHE', 'KAILAHUN', 'KAMBIA', 'KENEMA', 'KONIADUGU', ...
%    'KONO', 'MOYAMBA', 'PORT LOKO', 'PUJEHUN', 'PUJEHUN', 'TONKOLiLi', 'WESTERN RURAL', 'WESTERN URBAN'}, 'fontsize', 6)