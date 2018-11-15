function [W1,W2,W1p,W2p,SSE,bias,biasprime,finalFirstBias,finalSecondBias,D,E,Y]=TLP(inputUnits,hiddenUnits,outputUnit,learningRate,a,alpha,X,D,epochMax,threshold)
%initialization
%bias=2.*rand(1,hiddenUnits)-1;
%biasprime=2.*rand(1,outputUnit)-1;
bias=[-0.686384224911209,-0.347931431867162,-0.371876142653070,0.789001327808511];
biasprime=-0.505951641471921;

bias1 = repmat(bias,1,4);
bias2 = repmat(biasprime,1,16);

X = [bias1; X];
%W1 = 2.*rand(hiddenUnits,inputUnits+1)-1;
%W2 = 2.*rand(outputUnit,hiddenUnits+1)-1;

W1 = [-0.378641968174702,0.742644133146044,0.506401065417709,0.114585361379858,-0.160964591973630;-0.182262183915658,-0.833688206493080,0.400085339059239,0.701357805180206,-0.283743294421927;0.416021788128106,-0.0765243232637374,-0.570975507672018,0.117130983605771,-0.0220249652410274;-0.712724809881015,-0.939221952677697,0.359809371046837,0.803547328095126,-0.488075717995618];
W2 = [0.858338537984793,-0.066486371579129,-0.491984298886110,-0.137563105443852,0.405060022504686];

W1p=W1;
W2p=W2;

DW1 = zeros(hiddenUnits,inputUnits+1);
DW2 = zeros(outputUnit,hiddenUnits+1);

W1a=zeros(hiddenUnits,inputUnits+1);
W2a=zeros(outputUnit,hiddenUnits+1);

T1=zeros(hiddenUnits,inputUnits+1);
T2=zeros(outputUnit,hiddenUnits+1);

SSETemp = zeros(1,epochMax);

%algorithm
for i=1:epochMax 
H1a = W1*X;
H1b = 1./(1+exp(-H1a));
finalFirstBias=X(1,1:hiddenUnits);

H1c = [bias2;H1b];
Y1 = W2*H1c;
Y = 1./(1+exp(-Y1));
finalSecondBias=H1c(1,1:outputUnit);

E = D - Y;
sse = sum(E.^2);
SSETemp(i) = sse;
disp(['epoch = ' num2str(i) ' sse = ' num2str(sse)]);

if (sum(abs(E)<threshold)>15)
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