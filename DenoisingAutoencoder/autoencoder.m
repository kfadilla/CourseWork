%parameters
hiddenUnits = 50;
input = babblef1;
inputUnits = length(input);
clean = cleanf;
maxEpoch = 50000000;
%initialization
%sigmoid : y = 1/(1+exp(-x))
%{
hiddenweight = 0.003 .*rand(hiddenUnits,inputUnits) - 0.0015;
hiddenweight = hiddenweight.';
hiddenbias = 0.00003 .*rand(1,hiddenUnits)-0.000015;

outputweight = hiddenweight.';
outputbias = 0.00003 .*rand(1,inputUnits)-0.000015;
SSE = zeros(1,5000000);
%}
%main loop

for i = 1:maxEpoch
    %calculate hidden layer
    hw = input * hiddenweight(1:inputUnits,:);
    hv = hw + hiddenbias;
    acthidden = 1./(1+exp(-hv));
    
    %calculate output
    ow = acthidden * outputweight;
    est = ow + outputbias;
    %because we have real value input, we dont need activation function here
        
    %calculate sum of squared error
    error = clean - est;
    ssd = 1/2 * sum(((est - clean).^2));
    disp(['epoch = ' num2str(i) ' error = ' num2str(ssd)]);
    %disp(['airport'' error = ' num2str(ssd)]);
    
    
    %store the SSE
    SSE(i) = ssd;
    
    %break condition
    if i > 1
        if (abs(ssd - SSE(i-1))) < 0.000001 
            break
        end
    end
    %update weight
    delta = est .* (1-est) .* error * 0.5;
    hiddenweight = hiddenweight +  hiddenweight .* delta.';
    outputweight = hiddenweight.';
end

%write audio file
audiowrite('testcases.wav', est, 8000)
