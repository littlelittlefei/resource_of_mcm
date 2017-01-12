clc
clear
load Ebola.txt;
data = Ebola;
data = data';
net = newsom(minmax(data),[1 3]);
net = train(net,data);
y = net(data);
classes=vec2ind(y);
hist(classes,64)
set(gcf,'color','w')
title('classification')
figure;
