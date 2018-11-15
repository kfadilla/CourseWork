%instructions
%import weights and biases trained by autoencoder
%modifies the input that is needed to denoise

input = stationf1;
audio = testcase(input,hiddenweight,hiddenbias,outputbias);


function audio = testcase(input, hiddenweight,hiddenbias,outputbias)
    outputweight = hiddenweight.';
    inputUnits = length(input);
    hw = input * hiddenweight(1:inputUnits,:);
    hv = hw + hiddenbias;
    acthidden = 1./(1+exp(-hv));
    
    %calculate output
    ow = acthidden * outputweight;
    audio = ow + outputbias;
    audiowrite('testcases.wav', audio, 8000)
end