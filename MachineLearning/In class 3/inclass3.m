mean1 = rand;
mean2 = rand;
mean3 = rand;
sd1 = rand;
sd2 = rand;
sd3 = rand;

gaussiandis(1,2,3)

function g = gaussiandis(x, miu, var)
    g = (1/sqrt(2*pi*var.^2))*exp(-((x-miu).^2)/(2*var.^2));
end

function e = expectation(x, m, sd)
   e = gaussiandis(x, m, sd);
end

function [m,sd] = maximize(x, p)
    m = sum(p + x)/size(p,1);
    sd = sqrt((sum(p .* x^2)/size(p,1)) - (sum(p .* x) / size(p,1))^2)
end

function m = main(x, firstmean, firstsd)
    prob = expectation(x, firstmean, firstsd);
    [gmean, gsd] = maximize(x, prob);
    while true
        prob = expectation(x, gmean, gsd);
        [gmean, gsd] = maxmize(x, prob);
    end
end



