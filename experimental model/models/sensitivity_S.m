clear
clc
model = char(unique(strrep(glob("model*_S_hour4.csv"),"_S_hour4.csv","")));

#Sensitivity
base = [7 9.666666667 9.666666667 11.33333333 7.666666667 1];
exp = [5.374407583  9.118483412 13.17061611 13.02843602 9.805687204 2.270142182];
old = [];
for i = 1:rows(model)
  thisFile = strcat(model(i,:),"_S_hour4.csv");
  if (exist(thisFile) == 2)
    file = csvread(strcat(model(i,:), "_S_hour4.csv"));
    new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))  mean(file(18:20,5))  mean(file(22:24,5))];
    new = 100*abs(new-exp)./exp;
    new = [old; i, new, mean(new)];
    old = new;
  endif
endfor

csvwrite("sensitivity_S_exp.csv", new);