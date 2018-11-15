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
mu = 0.05;

weight_hidden = -1 + 2 .*rand(16,16);
bias_hidden = -1 + 2 .*rand(4,1);

weight_output = -1 + 2 .*rand(16,4);
bias_output = -1 + 2 .*rand(1,1);

stopped = 0;
iter = 0;
while(iter ~= 10000)
    out = zeros(16,1);
    N = length(weight_hidden(1,:));
    for i = 1:N
        %Hidden
        H1 = bias_hidden(1) + data(i,1)*weight_hidden(i,1)+ data(i,2)*weight_hidden(i,5) + data(i,3)*weight_hidden(i,9)+ data(i,4)*weight_hidden(i,13);
        x(1) = sigma(H1);
        H2 = bias_hidden(2) + data(i,1)*weight_hidden(i,2)+ data(i,2)*weight_hidden(i,6) + data(i,3)*weight_hidden(i,10)+ data(i,4)*weight_hidden(i,14);
        x(2) = sigma(H2);
        H3 = bias_hidden(3) + data(i,1)*weight_hidden(i,3)+ data(i,2)*weight_hidden(i,7) + data(i,3)*weight_hidden(i,11)+ data(i,4)*weight_hidden(i,15);
        x(3) = sigma(H3);
        H4 = bias_hidden(4) + data(i,1)*weight_hidden(i,4)+ data(i,2)*weight_hidden(i,8) + data(i,3)*weight_hidden(i,12)+ data(i,4)*weight_hidden(i,16);
        x(4) = sigma(H4);
        
        %output layer
        out_layer = bias_output + x(1)*weight_output(i,1) + x(2)*weight_output(i,2) + x(3)*weight_output(i,3) + x(4)*weight_output(i,4);
        out(i) = sigma(out_layer);
        
        %delta
        delta_output = out(i)*(1-out(i))*(output(i)-out(i));
        
        delta_hidden1 = x(1)*(1-x(1))*weight_output(i,1)*delta_output;
        delta_hidden2 = x(2)*(1-x(2))*weight_output(i,2)*delta_output;
        delta_hidden3 = x(3)*(1-x(3))*weight_output(i,3)*delta_output;
        delta_hidden4 = x(4)*(1-x(4))*weight_output(i,4)*delta_output;
        
        delta_hidden = [delta_hidden1 delta_hidden2 delta_hidden3 delta_hidden4
            delta_hidden1 delta_hidden2 delta_hidden3 delta_hidden4
            delta_hidden1 delta_hidden2 delta_hidden3 delta_hidden4
            delta_hidden1 delta_hidden2 delta_hidden3 delta_hidden4];
        %update weight
        new_weight_hidden = zeros(N,N);
        new_weight_output = zeros(N,4);
        for a = 1:N
            for b = 1:N
                r = rem(b,4);
                if(r==0)
                    r = 4;
                end
                weight_hidden(a,b) = weight_hidden(a,b) + mu*data(i,r)*delta_hidden(b);
                if(b<5)
                    weight_output(a,b) = weight_output(a,b) + mu*x(r)*delta_output;
                end
            end
        end
    end
    out = transform(out);
    if(abs(out - output) <= 0.5)
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
