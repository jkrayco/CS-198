clear
#model = input('model = ', 's')
m = char("model1j", "model1k", "model1l");

#Time
base = [0.33333 3.00000 7.33333 9.66667 12.33333  14.00000  14.00000  15.66667];
exp = [2.657886 4.87845 6.262266  7.145663  7.722067  8.020709  8.139269  8.145075];
for i = 1:rows(m)
  clf
  clc
  model = m(i,:);
  filename = model;
  file = csvread(strcat(model,".csv"));
  if (rows(file)>10)
    x = file(3:10,2);
    new = [mean([file(2+x,6)  file(11+x,6)  file(20+x,6)]')]';
  else
    x = file(3:10,1);
    new = file(3:10,5);
  endif

  hold on;
  title(strcat(model," - Hydrogen VS Hour"));
  xlabel("Time (in hours)");
  ylabel("Hydrogen (in umol)");
  if (i == 1)
    plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  else
    plot(x,new,"r;New Model;",x,last,"g;Last Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  endif
  #text(x+0.1,new,num2str(new,"%.4f"));
  grid on;
  hold off;

  saveas(1,strcat(model,"_hour.png"));
  
  last = new;
endfor

#Catalyst
x = [0.025  0.075  0.1 0.2];
base = [0 1.333333333 13.66666667 63];
exp = [4.443349754  8.15270936  9.763546798 9.733990148];
for i = 1:rows(m)
  clf
  clc
  model = m(i,:);
  filename = model;
  file = csvread(strcat(model,"_cat_hour4.csv"));
  new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))];

  hold on;
  title(strcat(model," - Hydrogen VS Catalyst"));
  xlabel("Catalyst (in g)");
  ylabel("Hydrogen (in umol)");
  if (i == 1)
    plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  else
    plot(x,new,"r;New Model;",x,last,"g;Last Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  endif
  #text(x,new,num2str(new',"%.4f"));
  grid on;
  hold off;

  saveas(1,strcat(model,"_cat.png"));
  
  last = new;
endfor

#Sulfide
x = [0.005  0.01  0.025 0.05  0.1 0.3];
base = [12.33333333 14  15.33333333 15  11.33333333 1];
exp = [5.374407583  9.118483412 13.17061611 13.02843602 9.805687204 2.270142182];
for i = 1:rows(m)
  clf
  clc
  model = m(i,:);
  filename = model;
  file = csvread(strcat(model,"_S_hour4.csv"));
  new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))  mean(file(18:20,5))  mean(file(22:24,5))];

  hold on;
  title(strcat(model," - Hydrogen VS Sulfide"));
  xlabel("Sulfide (in M)");
  ylabel("Hydrogen (in umol)");
  if (i == 1)
    plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  else
    plot(x,new,"r;New Model;",x,last,"g;Last Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  endif
  #text(x,new,num2str(new',"%.4f"));
  grid on;
  hold off;

  saveas(1,strcat(model,"_S.png"));
  
  last = new;
endfor

#Sulfite
x = [0.01  0.025 0.05  0.1 0.3];
base = [31.66666667 24  18.66666667 10  2.666666667];
exp = [26.98305085  18.81355932 14.10169492 9.728813559 9.016949152];
for i = 1:rows(m)
  clf
  clc
  model = m(i,:);
  filename = model;
  file = csvread(strcat(model,"_SO3_hour4.csv"));
  new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))  mean(file(18:20,5))];

  hold on;
  title(strcat(model," - Hydrogen VS Sulfite"));
  xlabel("Sulfite (in M)");
  ylabel("Hydrogen (in umol)");
  if (i == 1)
    plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  else
    plot(x,new,"r;New Model;",x,last,"g;Last Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
  endif
  #text(x,new,num2str(new',"%.4f"));
  grid on;
  hold off;

  saveas(1,strcat(model,"_SO3.png"));
  
  last = new;
endfor

printf("END\n");