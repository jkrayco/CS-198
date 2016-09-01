clear
clf
clc

csv = csvread("result_sulfide240_sulfite240_run1.csv");
csv([1],:) = [];
x = csv(:,1);
y = csv(:,4);
plot(x,y);