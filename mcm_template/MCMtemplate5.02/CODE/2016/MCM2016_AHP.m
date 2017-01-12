clear;clc;

mat=zeros(3,3);
mat_1=zeros(5,5);
mat_2=zeros(4,4);
mat_3=zeros(3,3);

% Set a_i,j for i<j
mat_1(1,2:end)=[5 7 2 3];
mat_1(2,3:end)=[2 1/3 1];
mat_1(3,4:end)=[1/5 1/7];
mat_1(4,5:end)=1;

mat_2(1,2:end)=[4 2 2];
mat_2(2,3:end)=[1/2 1/2];
mat_2(3,4:end)=1;

mat_3(1,2:end)=[3 2];
mat_3(2,3:end)=1/2;

mat(1,2:end)=[2 6];
mat(2,3:end)=3;

% Complete matrix
for i=1:3
    for j=1:i
        if i==j
            mat(i,j)=1;
        else
           mat(i,j)=1/mat(j,i);
        end
    end
end

for i=1:5
    for j=1:i
        if i==j
            mat_1(i,j)=1;
        else
           mat_1(i,j)=1/mat_1(j,i);
        end
    end
end

for i=1:4
    for j=1:i
        if i==j
            mat_2(i,j)=1;
        else
           mat_2(i,j)=1/mat_2(j,i);
        end
    end
end

for i=1:3
    for j=1:i
        if i==j
            mat_3(i,j)=1;
        else
           mat_3(i,j)=1/mat_3(j,i);
        end
    end
end


X = load('On candidate list.txt');

% Feature Normalize
[X_norm, ~, ~] = featureNormalize(X);

CR = zeros(4,1);
[w1,CR(1)] = AHP(mat_1);
[w2,CR(2)] = AHP(mat_2);
[w3,CR(3)] = AHP(mat_3);

% Normalization
w1=w1/sum(w1);
w2=w2/sum(w2);
w3=w3/sum(w3);

y_school = X_norm(:,1:5)*w1;
y_under = X_norm(:,6:9)*w2;
y_graduate = X_norm(:,10:12)*w3;

[w,CR(4)] = AHP(mat);

w=w/sum(w);

score = [y_school y_under y_graduate]*w;

[b,i]=sort(score,'descend');
N=1:100;
Money_max = zeros(length(N),1);
Money_min = zeros(length(N),1);
for i=1:100
    Money_max(i) = 100000000*b(1)/sum(b(1:i,:));
    Money_min(i) = 100000000*b(i)/sum(b(1:i,:));
end
plot(N, Money_max, 'bx',N, Money_max, 'b');
axis([0 100 0 10000000]);
figure;
plot(N, Money_min, 'rx', N, Money_min,  'r');
axis([0 100 0 10000000]);
for i=1:100
    if Money_max(i)<5000000
        idx1=i-1;
        break;
    end
end
for i=1:100
    if Money_min(i)<2000000
        idx2=i-1;
        break;
    end
end
money_final = zeros(idx1,1);
for i=1:idx1
    money_final(i) = 100000000*b(i)/sum(b(1:idx1,:));
end

figure;
lab=[1 2 3 4];
plot(lab,CR','bx',[0 5],[0.1 0.1],'r');
axis([0 5 -0.1 0.5]);
set(gca,'xtick',[])