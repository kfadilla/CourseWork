%1a
file = csvread("in_class2_data.csv")
%1b
col1 = histogram(file(:,1))
col2 = histogram(file(:,2))
%Column1 data is leaning towards -1, it is a normal distribution
%CColumn2 data is leaning towards 1, it is also a normal distribution
%1c
mleE1 = sum(file(:,1))/length(file(:,1)) %-0.9876
mleE2 = sum(file(:,2))/length(file(:,2)) %0.9876
%1d
mleVar1 = sum((file(:,1) - mleE1).^2)/length(file(:,1)) %1.0927
mleVar2 = sum((file(:,2) - mleE2).^2)/length(file(:,2)) %0.9447

%2a
first = file(:,1)
like1 = []
for i = 1 : length(first)
    like1 = [like1 ; likelihood_x(first(i))]
end


%2b
second = file(:,2)
like2 = []
for i = 1 :length(second)
    like2 = [like2 ; likelihood_x(second(i))]
end

%2c
decision1 = []
for i = 1 : length(like1)
    temp = like1(i,:)
    left = temp(1)
    right = temp(2)
    decision1 = [decision1 ; right > left]
end

decision2 = []
for i = 1 : length(like2)
    temp = like2(i,:)
    left = temp(1)
    right = temp(2)
    decision2 = [decision2 ; right > left]
end
%2d
error1 = 0
for i = 1:length(decision1)
    if decision1(i) ~= 0
        error1 = error1 + 1
    end
end

derror1 = error1/length(decision1)
error2 = 0

for i = 1:length(decision2)
    if decision2(i) ~= 1
        error2 = error2 + 1
    end
end

derror2 = error2/length(decision2)

%2e
PE = (derror1+derror2)/2

function f = likelihood_x(x)
e1 = -0.9876
e2 = 0.9875
var1 = 1.0927
var2 = 0.9447
p1 = normpdf(x,e1,sqrt(var1))
p2 = normpdf(x,e2,sqrt(var2))
f(1) = p1
f(2) = p2
end
