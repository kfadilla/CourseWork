
function [inputweight,outputweight,SSE,inputbias,outputbias,finalFirstBias,finalSecondBias,output,Error,Y]=TLP(learningRate,a,alpha,input,output,epochMax,stopping)

inputbias=2.*rand(1,4)-1;
outputbias=2.*rand(1,1)-1;
bias1 = repmat(inputbias,1,4);
bias2 = repmat(outputbias,1,16);
input = [bias1; input];
%inputweight = 2.*rand(4,5)-1;
%inputw = inputweight
inputweight = [0.262377468538022,0.304902145937230,-0.949730028579594,-0.259274626969604,-0.646289884749395;-0.289852696242302,0.209981283816519,-0.157775492469517,0.683120174936412,0.914768045191447;0.994006543213295,-0.225509137033730,-0.631799421144978,0.468459382386626,-0.469355927614160;-0.551657002033746,-0.715625681418992,0.451550534938906,0.142051745648758,0.849161790479202]
%outputweight = 2.*rand(1,5)-1;
%outputw = outputweight
outputweight = [-0.552459190605918,-0.252872384714710,-0.824999300846829,0.280233096493430,-0.638766224493783];
W1a=zeros(4,5);
W2a=zeros(1,5);

SSETemp = zeros(1,epochMax);

for i=1:epochMax 
hidden = inputweight*input;
acthidden = 1./(1+exp(-hidden));
finalFirstBias=input(1,1:4);

updatedhidden = [bias2;acthidden];
est = outputweight*updatedhidden;
Y = 1./(1+exp(-est));
finalSecondBias=updatedhidden(1,1);

Error = output - Y;
sse = sum(Error.^2);
SSETemp(i) = sse;

if (sum(abs(Error)<stopping)>15)
    SSE=SSETemp(1:i);
    disp(['epoch = [' num2str(i) ']']);
    return
end

d3 = Y.*(1-Y);
d2 = a.*d3 .* Error;
DW2 = learningRate * d2 * updatedhidden';
Temp2=outputweight;
outputweight = outputweight + DW2+alpha*W2a;
W2a=Temp2;

d3= updatedhidden.*(1-updatedhidden);
d1 = a.*d3 .* (outputweight' * d2);
d1 = d1(2:end,:);
DW1 = learningRate* d1*input';
Temp1=inputweight;
inputweight = inputweight + DW1+alpha*W1a;
W1a=Temp1;
end

SSE = SSETemp;
end