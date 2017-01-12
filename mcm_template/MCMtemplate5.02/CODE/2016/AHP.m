function [w,CR] = AHP(A)
n = size(A,1);
m = size(A,2);
if n ~= m
    fprintf('Error, A must be a square matric.\n');
    return
end
[V,D] = eig(A);
D_colonm = diag(D);
lambda = max(D_colonm);
w = V(:,find(D_colonm==lambda));

CI = (lambda-n)/(n-1);
RI = [0 0 0.58 0.90 1.12 1.24 1.32 1.41 1.45 1.49 1.51];%data only for n = 1~11
CR = CI/RI(n);%Consistency condition checking
if CR >= 0.1
    fprintf('Consistency condition check: Unsatisfied\n');
end
end