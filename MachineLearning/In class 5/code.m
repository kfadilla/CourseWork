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
inputbias = -1 + 2 .*rand(16,1)
inputweight = -1 + 2 .* rand(16,16)
outputweight = -1 + 2 .* rand(16,4)
error = 1

while (error > 0.05)
inputLayerValue = est(input, inputbias, inputweight);
updatedinputweight = delta(0.05,inputweight, input, output,inputLayerValue);
updatedhidden = est(input, inputbias, updatedinputweight);

estoutput = est(updatedhidden, inputbias, outputweight);
updatedoutputweight = delta(0.05,outputweight, updatedhidden, output,estoutput);
updatedestoutput = est(updatedhidden, inputbias, updatedoutputweight);

error = abs(updatedoutputweight - outputweight);
inputweight = updatedinputweight;
outputweight = updatedoutputweight;
end
misplace(updatedestoutput, output)

function ret = est(inp, b, w)
   ret = zeros(length(inp),1);
   data = zeros(length(w),length(w(1,:)));
   for i = 1:length(w)
       counting = length(w(1,:))/length(inp(1,:))
       for j = 1:length(w(i,:))
           if (j <= counting)
               temp = 1;
           end
           if (and(j > counting, j<=counting*2))
               temp = 2;
           end
           if (and(j > counting*2, j <= counting*3))
               temp = 3;
           end
           if (j > counting * 3)
               temp = 4;
           end
           data(i,j) = inp(i,temp) * w(i,j);
       end
   end
   for i = 1:length(data)
       temp = sum(data(i,:)) + b(i,1);
       if (temp >= 0)
           ret(i,1) = 1;
       else
           ret(i,1) = 0;
       end
   end
end

function nw = delta(miu, ow, input, ideal, actual)
   nw = zeros(length(ow),length(ow(1,:)));
   for i = 1:length(input)
       diff = ideal(i,1) - actual(i,1);
       counting = length(ow(1,:))/length(input(1,:));
       for j = 1:length(ow(i,:))
           if (j <= counting)
               temp = 1;
           end
           if (and(j > counting, j<=counting*2))
               temp = 2;
           end
           if (and(j > counting*2, j <= counting*3))
               temp = 3;
           end
           if (j > counting * 3)
               temp = 4;
           end
           nw(i,j) = input(i,temp) .* diff * miu;
       end
   end
end

function m = misplace(ideal, actual)
    m = 0;
    for i = 1:16
        if (ideal(i,1) ~= actual(i,1))
            m = m + 1;
        end
    end
end