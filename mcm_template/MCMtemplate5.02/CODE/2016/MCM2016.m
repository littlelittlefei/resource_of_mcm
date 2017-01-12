clear;clc;

% Training data loading
X = load('X_Gates.txt');
Y = load('Y_Gates.txt');

% Feature Normalize
[X_norm, ~, ~] = featureNormalize(X);
Y = Y/sum(Y);

X_norm = [ones(size(X_norm,1),1) X_norm];

X_train=X_norm(1:30,:);
X_val=X_norm(31:end,:);

Y_train=Y(1:30,:);
Y_val=Y(31:end,:);

initial_theta = zeros(size(X_norm, 2), 1);

% Set regularization parameter lambda to 1
lambda = 1;

% Compute and display initial cost and gradient for regularized logistic regression
[cost, grad] = costFunctionReg(initial_theta, X_train, Y_train, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);

% Set Options
options = optimset('GradObj', 'on', 'MaxIter', 400);

% Optimize
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X_train, Y_train, lambda)), initial_theta, options);

[cost, grad] = costFunctionReg(theta, X_train, Y_train, lambda);

fprintf('Cost at trained theta: %f\n', cost);
% Compute result of our own data
X_self = load('X_self.txt');

[X_self, ~, ~] = featureNormalize(X_self);
X_self = [ones(size(X_self,1),1) X_self];

Y_self = X_self*theta;

m = 30;
% Learning Curve
lambda = 0;
[error_train, error_val] = ...
    learningCurve(X_train, Y_train, ...
                  X_val, Y_val, ...
                  lambda);
              
plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 1.50])

pause;
% lambda
[lambda_vec, error_train, error_val] = ...
    validationCurve(X_train, Y_train, X_val, Y_val);

close all;
plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');
