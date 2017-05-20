clear
clc
model = strrep(glob("model_test*.csv"),".csv","");
model = char(unique(strrep(model,"_hour4","")));

#Sensitivity
base = [0 1.666666667 4 6.333333333 9 10.66666667 10.66666667 11.66666667];
exp = [2.657886 4.87845 6.262266  7.145663  7.722067  8.020709  8.139269  8.145075];
old = [];
old2 = [];
for i = 1:rows(model)
  #printf("%d\n", exist(strcat(model(i,:), ".csv")));
  if (exist(strcat(model(i,:), ".csv")) == 2)
    file = csvread(strcat(model(i,:), ".csv"));
    if (rows(file)>10)
      %x = file(3:10,2)';
      new = [mean([file(3:10,6)  file(12:19,6)  file(21:28,6)]')];
    else
      %x = file(3:10,1)';
      new = file(4:10,5)';
    endif
  endif
  new2 = 100*abs(new-base)./base;
  new = 100*abs(new-exp)./exp;
  new2 = [old2; i, new2, mean(new2(2:end))];
  new = [old; i, new, mean(new)];
  old = new;
  old2 = new2;
endfor

csvwrite("sensitivity_exp.csv", new);
csvwrite("sensitivity_base.csv", new2);