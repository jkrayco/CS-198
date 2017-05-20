clear
clc
model = char(unique(strrep(glob("model_test_*_cat_hour4.csv"),"_cat_hour4.csv","")));

#Sensitivity
base = [0 1.666666667 6 7.666666667];
exp = [4.443349754  8.15270936  9.763546798 9.733990148];
old = [];
old2 = [];
for i = 1:rows(model)
  thisFile = strcat(model(i,:),"_cat_hour4.csv");
  if (exist(thisFile) == 2)
    file = csvread(strcat(model(i,:), "_cat_hour4.csv"));
    new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))];
  endif
  new2 = 100*abs(new-base)./base;
  new = 100*abs(new-exp)./exp;
  new2 = [old2; i, new2, mean(new2(2:end))];
  new = [old; i, new, mean(new)];
  old = new;
  old2 = new2;
endfor

csvwrite("sensitivity_cat_exp.csv", new);
csvwrite("sensitivity_cat_base.csv", new2);