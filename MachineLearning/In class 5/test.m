input = [0 0 0 0;
        0 0 0 1;
        0 0 1 0;
        0 0 1 1
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
        1 1 1 1]

output = [0;
    1;
    1;
    0;
    1;
    0;
    0;
    1;
    1;
    0;
    0;
    1;
    0;
    1;
    1;
    0;]

bias = -1 + 2 .*rand(5,1)

inputweight1 = -1 + 2 .* rand(16,4)
inputweight2 = -1 + 2 .* rand(16,4)
inputweight3 = -1 + 2 .* rand(16,4)
inputweight4 = -1 + 2 .* rand(16,4)
outputweight = -1 + 2 .* rand(16,4)
estoutput = zeros(16,1)
iter = 0
while (error > 0.05)
h1 = estimate(input, inputweight1,bias(1,1));
h2 = estimate(input, inputweight2,bias(2,1));
h3 = estimate(input, inputweight3,bias(3,1));
h4 = estimate(input, inputweight4,bias(4,1));

temp1 = zeros(16,1)
for i = 1:16
    temp1(i,1) = h1(i,1) * outputweight(i,1);
end
temp2 = zeros(16,1)
for i = 1:16
    temp2(i,1) = h2(i,1) * outputweight(i,2);
end
temp3 = zeros(16,1)
for i = 1:16
    temp3(i,1) = h3(i,1) * outputweight(i,3);
end
temp4 = zeros(16,1)
for i = 1:16
    temp4(i,1) = h4(i,1) * outputweight(i,4);
end
tempoutput = temp1 + temp2 + temp3 + temp4
estoutput = activation(tempoutput);
error = err(estoutput, output);
deltaout = delta(0.5, output,estoutput);
h1d = gendelta(0.9, h1, inputweight1, deltaout(1:4,1))
h2d = gendelta(0.9, h2, inputweight2, deltaout(5:8,1))
h3d = gendelta(0.9, h3, inputweight3, deltaout(9:12,1))
h4d = gendelta(0.9, h4, inputweight4, deltaout(13:16,1))
inputweight1 = newweight(input,h1d,inputweight1)
inputweight2 = newweight(input,h2d,inputweight2)
inputweight3 = newweight(input,h3d,inputweight3)
inputweight4 = newweight(input,h4d,inputweight4)
iter = iter + 1
end
function nw = newweight(input,d,ow)
    for i = 1:16
        for j = 1:length(ow(1,:))
            nw(i,j) = ow(i,j) + input(i,j) * d;
        end
    end
end
function de = delta(miu, ideal, actual)
    dif = ideal - actual;
    de = actual .* (1 - actual) .* miu .* dif;
end

function m = err(ideal, actual)
    m = abs(actual - ideal)
end


function a = activation(layer)
    a = 1./(1+exp(-layer));
end
function gd = gendelta(alpha, layer, ow, delta)
    gd = (layer .* (1-layer))' * ow * delta * alpha;
end
function est = estimate(input, weight, bias)
    est = zeros(16,1)
    for i = 1:16
        temp = 0
        for j = 1:length(weight(1,:))
            temp = temp + input(i,j) * weight(i,j);
        end
        est(i,1) = temp + bias;
    end
    est = 1./(1+exp(-est)); %activation rule, sigma
end