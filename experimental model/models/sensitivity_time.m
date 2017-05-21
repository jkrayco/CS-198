clear
clc
model = strrep(glob("model*_time.csv"),".csv","");
model = char(unique(strrep(model,"_time","")));

#Sensitivity
base = [0 1.666666667 4 6.333333333 9 10.66666667 10.66666667 11.66666667];
exp = [2.657886 4.87845 6.262266  7.145663  7.722067  8.020709  8.139269  8.145075];
old = [];
for i = 1:rows(model)
  #printf("%d\n", exist(strcat(model(i,:), ".csv")));
  if (exist(strcat(model(i,:), "_time.csv")) == 2)
    file = csvread(strcat(model(i,:), "_time.csv"));
    if (rows(file)>10)
      %x = file(3:10,2)';
      new = [mean([file(3:10,6)  file(12:19,6)  file(21:28,6)]')];
    else
      %x = file(3:10,1)';
      new = file(4:10,5)';
    endif
  new = 100*abs(new-exp)./exp;
  new = [old; i, new, mean(new)];
  old = new;
  endif
endfor

csvwrite("sensitivity_exp.csv", new);