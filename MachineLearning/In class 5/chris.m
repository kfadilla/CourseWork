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
output = [0;1;1;0;1;0;0;1;1;0;0;1;0;1;1;0];
mu = 0.5;

weight_hidden = -1 + 2 .*rand(4,4);
bias_hidden = -1 + 2 .*rand(4,1);

weight_output = -1 + 2 .*rand(4,1);
bias_output = -1 + 2 .*rand(1,1);

stopped = 0;
iter = 0;
while(iter ~= 10000000)
    out = zeros(length(data(:,1)),1);
    N = length(data(:,1));
    for i = 1:N
        %Hidden
        H1 = bias_hidden(1) + data(i,1)*weight_hidden(1,1)+ data(i,2)*weight_hidden(1,2) + data(i,3)*weight_hidden(1,3)+ data(i,4)*weight_hidden(1,4);
        x(1) = sigma(H1);
        H2 = bias_hidden(2) + data(i,1)*weight_hidden(2,1)+ data(i,2)*weight_hidden(2,2) + data(i,3)*weight_hidden(2,3)+ data(i,4)*weight_hidden(2,4);
        x(2) = sigma(H2);
        H3 = bias_hidden(3) + data(i,1)*weight_hidden(3,1)+ data(i,2)*weight_hidden(3,2) + data(i,3)*weight_hidden(3,3)+ data(i,4)*weight_hidden(3,4);
        x(3) = sigma(H3);
        H4 = bias_hidden(4) + data(i,1)*weight_hidden(4,1)+ data(i,2)*weight_hidden(4,2) + data(i,3)*weight_hidden(4,3)+ data(i,4)*weight_hidden(4,4);
        x(4) = sigma(H4);
        
        %output layer
        out_layer = bias_output + x(1)*weight_output(1) + x(2)*weight_output(2) + x(3)*weight_output(3) + x(4)*weight_output(4);
        out(i) = sigma(out_layer);
        
        %delta
        delta_output = out(i)*(1-out(i))*(output(i)-out(i))*0.5;
        
        delta_hidden1 = x(1)*(1-x(1))*weight_output(1)*delta_output;
        delta_hidden2 = x(2)*(1-x(2))*weight_output(2)*delta_output;
        delta_hidden3 = x(3)*(1-x(3))*weight_output(3)*delta_output;
        delta_hidden4 = x(4)*(1-x(4))*weight_output(4)*delta_output;
        
        %update weight
        for k = 1:4
            weight_hidden(1,k) = weight_hidden(1,k) + mu*data(i,1)*delta_hidden1;
            weight_hidden(2,k) = weight_hidden(2,k) + mu*data(i,2)*delta_hidden2;
            weight_hidden(3,k) = weight_hidden(3,k) + mu*data(i,3)*delta_hidden3;
            weight_hidden(4,k) = weight_hidden(3,k) + mu*data(i,4)*delta_hidden4;
            
            weight_output(k) = weight_output(k) + mu*delta_output*x(k);
        end
    end
    out = transform(out);
    if(abs(out - output) <= mu)
        stopped = 1;
    end
    iter = iter +1;
    disp(iter)
end
error = calc_error(output,out,0);
function [sig] =  sigma(x)
    sig = 1./(1+exp(-x));
end

function [error] = calc_error(ori,act,error)
    for i = 1:length(ori)
        if ori(i,1) ~= act(i,1)
            error = error + 1;
        end
    end
end

function [output] = transform(output)
    for i = 1:length(output)
        if(output(i)>0.50)
            output(i) = 1;
        else
            output(i) = 0;
        end
    end
end
