%parameters
hiddenUnits = 500;
input = train_nolabel;
inputUnits = 58;
clean = train(:,2);

%initialization
%sigmoid : y = 1/(1+exp(-x))

hiddenweight = 0.003 .*rand(hiddenUnits,inputUnits) - 0.0015;
hiddenweight = hiddenweight.';
hiddenbias = 0.00003 .*rand(1,hiddenUnits)-0.000015;

outputweight = hiddenweight.';
outputbias = 0.00003 .*rand(1,inputUnits)-0.000015;
SSE = zeros(1,5000000);

%main loop
for i = 1:5000000
    %calculate hidden layer
    for j = 1:length(input(:,1))
        hw = input(i,:) * hiddenweight(1:inputUnits,:);
        hv = hw + hiddenbias;
        acthidden = 1./(1+exp(-hv));
        
        %calculate output
        ow = acthidden * outputweight;
        est = ow + outputbias;
        est = 1./(1+exp(-est));
        
        %calculate sum of squared error
        error = clean - est;
        ssd = 1/2 * sum(((est - clean).^2));
        disp(['epoch = ' num2str(j) ' error = ' num2str(ssd)]);
        %disp(['airport'' error = ' num2str(ssd)]);
        
        %break condition
        if ssd < 0.1
            break
        end
        
        %store the SSE
        SSE(i) = ssd;
        
        %update weight
        delta = est .* (1 - est) .* error;
        hiddenweight = hiddenweight +  hiddenweight .* delta.';
        outputweight = hiddenweight.';
    end
end

%write audio file
audiowrite('temp.wav',est,8000)