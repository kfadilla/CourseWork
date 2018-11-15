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

bias_input = -1 + 2 .*rand(16,1);
bias_output = -1 + 2 .*rand(16,1);
weight_input = -1 + 2 .*rand(16,16);
weight_output = -1 + 2 .*rand(16,4);
abso = 1/0;
iter = 0;

while(abso>0.05)
    input_noutput = estimate(data,bias_input,weight_input);
    new_input_weight = delta(0.05,weight_input,data,output,input_noutput);
    updated_result = estimate(data,bias_input,new_input_weight);

    output_noutput = estimate(updated_result,bias_input,weight_output);
    new_output_weight = delta(0.05,weight_output,updated_result,output,output_noutput);

    abso = absolute_error(weight_input,new_input_weight)/256;
    weight_input = new_input_weight;
    weight_output = new_output_weight;
    iter = iter+1;
end

error = calc_error(output,updated_result,0);
function [est] = estimate(input,bias,weight)
    est = zeros(length(input),1);
    data = zeros(length(weight),length(weight(1,:)));
    for i = 1:length(weight)
        standard = length(weight(1,:))/length(input(1,:));
        for j = 1:length(weight(i,:))
            if(j<=standard)
                temp = 1;
            end
            if(and(j>standard,j<=standard*2))
                temp = 2;
            end
            if(and(j>standard*2,j<=standard*3))
                temp = 3;
            end
            if(j>standard*3)
                temp = 4;
            end
            data(i,j) = input(i,temp) * weight(i,j);
        end
    end
    for i = 1:length(data)
        temp = sum(data(i,:)) + bias(i,1);
    end
    est = 1./(1+exp(-est));
end

function [nw] = delta(mu,original_weight,input,output,actual)
    nw = zeros(length(original_weight),length(original_weight(1,:)));
    for i = 1:length(input)
        diff = output(i,1) - actual(i,1);
        standard = length(original_weight(1,:))/length(input(1,:));
        for j = 1:length(original_weight(i,:))
            if(j<=standard)
                temp = 1;
            end
            if(and(j>standard,j<=standard*2))
                temp = 2;
            end
            if(and(j>standard*2,j<=standard*3))
                temp = 3;
            end
            if(j>standard*3)
                temp = 4;
            end
            nw(i,j) = input(i,temp) .* diff .* mu;
        end
    end
end 

function [error] = calc_error(ori,act,error)
    for i = 1:length(ori)
        if ori(i,1) ~= act(i,1)
            error = error + 1;
        end
    end
end

function [SSE] = SSE_error(ori,act)
    SSE = sum(sum(abs(act - ori).^2));
end

function [error] = absolute_error(ori,act)
    error = sum(sum(abs(act - ori)));
end
