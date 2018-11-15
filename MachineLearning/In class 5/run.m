learningRate = 0.05;
alpha = 0;
a=1;

epochMax = 500000000;
threshold = 0.05;

X = [0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 ;0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1; 0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1; 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];
D = [0 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0];

[W1,W2,SSE,bias1,bias2,ffb,fsb,D,E,Y]=TLP(learningRate,a,alpha,X,D,epochMax,threshold);

%1. Specification of number of weights and biases for each network layer.
disp(['The number of weights of the first layer = [' num2str(length(W1)*length(W1(1,:))) ']']);
disp(['The number of biases of the first layer = [' num2str(length(bias1)) ']']);
disp(['The number of weights of the second layer = [' num2str(length(W2)*length(W2(1,:))) ']']);
disp(['The number of biases of the second layer = [' num2str(length(bias2)) ']']);

%2. Plot of the total square error evaluated at each epoch
plot(SSE);

%3. Display the final weight and bias values to the screen
disp('The final weights of the first layer = ');
disp(W1);
disp('The final weights of the second layer = ');
disp(W2);
disp('The final biases of the first layer = ');
disp(bias1);
disp('The final biases of the second layer = ');
disp(bias2);

disp(['D = [' num2str(D) ']']);
disp(['Y = [' num2str(Y) ']']);
disp(['absError = [' num2str(abs(E)) ']']);

%4. Matlab programming code