id = fopen('data1.txt');
num = textscan(id, "%n");
nums = cell2mat(num);
fclose(id);

%Q2
[mu3, sigma3, prior3] = main(nums, 3, 0.001)
%Q3
%[mu2, sigma2, prior2] = main(nums, 2, 0.001)
%[mu4, sigma4, prior4] = main(nums, 4, 0.001)

% MAIN OUTER LOOP
function [mu, sigma, prior] = main(data, i, threshold)
    mu = [];
    sigma = [];
    prior = [];
    llh = [];%for plotting llh
    
    for class = 1:i
       mu = [mu, rand];
       sigma = [sigma, rand];
       prior = [prior, 1/i];
    end
    
    originllh = -inf;
    newllh = likelihood(data, mu, sigma, prior, i);
    llh = [llh, newllh];    
    while newllh - originllh > threshold
        n = expectation(data, mu, sigma, prior, i);
        [mu, sigma, prior] = maximize(data, mu, sigma, prior, n, i);
        originllh = newllh;
        newllh = likelihood(data, mu, sigma, prior, i);
        llh = [llh, newllh];
    end
    plot(llh)
end


function n = expectation(data, mu, sigma, prior, i)
    
    for a = 1:i 
        n(a) = 0;
        for b = 1:length(data)
            pxcb = pxgivenc(data(b), mu(a), sigma(a), prior(a));
                
            px = 0;
            for c = 1:i
                p = pxgivenc(data(b), mu(c), sigma(c), prior(c));
                px = px + p; 
            end            
            n(a) = n(a) + pxcb/px;  
        end
    end
end

%Maximization
function [mu, sigma, prior] = maximize(data, mu, sigma, prior, n, i)
 
    for a = 1:i
        valuesum = 0;
        valuesumofx2 = 0;
        for b = 1:length(data)
            pxcb = pxgivenc(data(b), mu(a), sigma(a), prior(a));  
            px = 0;            
            for c = 1:i
                p = pxgivenc(data(b), mu(c), sigma(c), prior(c));
                px = px + p; 
            end
            pij = pxcb/px; 
            valuesum = valuesum + pij * data(b); 
            valuesumofx2 = valuesumofx2 + pij * data(b)^2; 
        end
        mu(a) = valuesum / n(a);
        sigma(a) = sqrt(valuesumofx2 / n(a) - mu(a)^2);%%%%%%%%%%%%%%%
        prior(a) = n(a)/length(data);
    end

end
  

%P(x | c)P(c)
function pxc = pxgivenc(x, mu, sigma, prior)
    g = normpdf(x, mu, sigma);
    pxc = g * prior;    
end


%Log Likelyhood function
function llh = likelihood(data, mu, sigma, prior, i)
    llh = 0;
    for j = 1:length(data)
        p = 0;
        for class = 1:i
            p = p + pxgivenc(data(j), mu(class), sigma(class), prior(class));
        end
        llh = llh + log10(p);
    end
end
    
