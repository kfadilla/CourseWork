train = csvread('train.csv',1,0);
test = csvread('test.csv',1,0);
train_nolabel = train;
train_nolabel(:,2) = [];


global train_nolabel;
global train;
global test;