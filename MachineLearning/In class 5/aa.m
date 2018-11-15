data = [0 0 0 0;
        0 0 0 1;
        0 0 1 0;
        0 0 1 1;
        0 1 0 0;
        0 1 0 1;
        0 1 1 0;
        0 1 1 1;
        1 0 0 0;
        1 0 0 1;
        1 0 1 0;
        1 0 1 1;
        1 1 0 0;
        1 1 0 1;
        1 1 1 0;
        1 1 1 1;];
input = data.'
output = [0 1 1 0 1 0 0 1 1 0 0 1 0 1 1 0];
weight1;weight2;sse;b1;b2) = TLP(4,4,1,0.05,1,1,input,output,500000000,0.05)
function [W1,W2,SSE,bias1,bias2]=TLP(inputUnits,hiddenUnits,outputUnit,learningRate,a,alpha,X,D,epochMax,t)
N = length(X(1,:));
bias1 = 2.*rand(1,N)-1;
bias2 = 2.*rand(1,N)-1;
X = [bias1; X];
W1 = 2.*rand(hiddenUnits,inputUnits+1)-1;
W2 = 2.*rand(outputUnit,hiddenUnits+1)-1;
DW1 = zeros(hiddenUnits,inputUnits+1);
DW2 = zeros(outputUnit,hiddenUnits+1);

W1a=zeros(hiddenUnits,inputUnits+1);
W2a=zeros(outputUnit,hiddenUnits+1);

T1=zeros(hiddenUnits,inputUnits+1);
T2=zeros(outputUnit,hiddenUnits+1);

SSETemp = zeros(1,epochMax);

for i=1:epochMax 
H1a = W1*X;
H1b = 1./(1+exp(-H1a));
H1c = [bias2;H1b];

Y1 = W2*H1c;
Y = 1./(1+exp(-Y1));
E = D - Y;

sse = sum(E.^2);
SSETemp(i) = sse;
disp(['epoch = ' num2str(i) ' sse = ' num2str(sse)]);
disp(['absError = [' num2str(abs(E)) ']']);
%disp(['D = [' num2str(abs(D)) ']']);
%disp(['Y = [' num2str(abs(Y)) ']']);
%disp('next')

if (sum(abs(E)<0.05)>15)
    SSE=SSETemp(1:i);
    return
end

d3 = Y.*(1-Y);
d2 = a.*d3 .* E;

DW2 = learningRate * d2*H1c';
T2=W2;
W2 = W2 + DW2+alpha*W2a;
W2a=T2;

d3= H1c.*(1-H1c);

d1 = a.*d3 .* (W2' * d2);
d1 = d1(2:end,:);
DW1 = learningRate* d1*X';
T1=W1;
W1 = W1 + DW1+alpha*W1a;
W1a=T1;
end

SSE = SSETemp;
end