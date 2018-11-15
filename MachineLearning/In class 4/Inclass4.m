pred1 = importdata('pred1.dat');
resp1 = importdata('resp1.dat');
firstpred1 = pred1(1:500,1:50);
secpred1 = pred1(501:1000,1:50);
firstresp1 = resp1(1:500,1);
secresp1 = resp1(501:1000,1);

pred2 = importdata('pred2.dat');
resp2 = importdata('resp2.dat');
firstpred2 = pred2(1:500,1:500);
secpred2 = pred2(501:1000,1:500);
firstresp2 = resp2(1:500,1);
secresp2 = resp2(501:1000,1);

w1 = est(firstpred1, firstresp1);
w2 = est(firstpred2, firstresp2);
plot(w1);
plot(w2);
SSE1 = sum((secpred1 * w1 - secresp1).^2);
SSE2 = sum((secpred2 * w2 - secresp2).^2);


function b = est(pred, resp)
    b = inv(pred.' * pred) * pred.' * resp
end


