clear
clc
model = char(unique(strrep(glob("model*_SO3_hour4.csv"),"_SO3_hour4.csv","")));

#Sensitivity
base = [16 15.33333333 9 8 8.666666667 ];
exp = [26.98305085  18.81355932 14.10169492 9.728813559 9.016949152];
old = [];
for i = 1:rows(model)
  thisFile = strcat(model(i,:),"_SO3_hour4.csv");
  if (exist(thisFile) == 2)
    file = csvread(strcat(model(i,:), "_SO3_hour4.csv"));
    new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))  mean(file(18:20,5))];
    new = 100*abs(new-exp)./exp;
    new = [old; i, new, mean(new)];
    old = new;
  endif
endfor

csvwrite("sensitivity_SO3_exp.csv", new);