function graph(option)
  clc
  model = strrep(glob("model*.csv"),".csv","");
  model = strrep(model,"_hour4","");
  model = strrep(model,"_time","");
  model = strrep(model,"_cat","");
  model = strrep(model,"_SO3","");
  model = char(unique(strrep(model,"_S","")));
  
  if (option == 0 || option == 1)
    #Time
    base = [0 1.666666667 4 6.333333333 9 10.66666667 10.66666667 11.66666667];
    exp = [2.657886 4.87845 6.262266  7.145663  7.722067  8.020709  8.139269  8.145075];
    for i = 1:rows(model)
      if (exist(strcat(model(i,:), "_time.csv")) == 2)
        clf
        clc
        file = csvread(strcat(model(i,:), "_time.csv"));
        if (rows(file)>10)
          x = file(3:10,2);
          new = [mean([file(3:10,6)  file(12:19,6)  file(21:28,6)]')]';
        else
          x = file(3:10,1);
          new = file(3:10,5);
        endif

        hold on;
        title(strcat(strrep(model,"_", " ")," - Hydrogen VS Time (RMSE = ", num2str(RMSE(new,exp),5), " umol)"));
        xlabel("Time (in hours)");
        ylabel("Hydrogen (in umol)");
        plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
        #text(x+0.1,new,num2str(new,"%.4f"));
        grid on;
        hold off;

        saveas(1,strcat(model(i,:),"_time.png"));
      endif
    endfor
    pause(2);
  elseif (option == 0 || option == 2)
    #Catalyst
    pause(2);
    x = [0.025  0.075  0.1 0.2];
    base = [0 1.666666667 6 7.666666667];
    exp = [4.443349754  8.15270936  9.763546798 9.733990148];
    for i = 1:rows(model)
      thisFile = strcat(model(i,:),"_cat_hour4.csv");
      if (exist(thisFile) == 2)
        clf
        clc
        file = csvread(thisFile);
        new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))];

        hold on;
        title(strcat(strrep(model,"_", " ")," - Hydrogen VS Catalyst (RMSE = ", num2str(RMSE(new,exp),5), " umol)"));
        xlabel("Catalyst (in g)");
        ylabel("Hydrogen (in umol)");
        plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
        #text(x,new,num2str(new',"%.4f"));
        grid on;
        hold off;

        saveas(1,strcat(model(i,:),"_cat.png"));
      endif
    endfor
    pause(2);
  elseif (option == 0 || option == 3)
    #Sulfide
    x = [0.005  0.01  0.025 0.05  0.1 0.3];
    base = [7 9.666666667 9.666666667 11.33333333 7.666666667 1];
    exp = [5.374407583  9.118483412 13.17061611 13.02843602 9.805687204 2.270142182];
    for i = 1:rows(model)
      if (exist(strcat(model(i,:),"_S_hour4.csv")) == 2)
        clf
        clc
        file = csvread(strcat(model(i,:),"_S_hour4.csv"));
        new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))  mean(file(18:20,5))  mean(file(22:24,5))];

        hold on;
        title(strcat(strrep(model,"_", " ")," - Hydrogen VS Sulfide (RMSE = ", num2str(RMSE(new,exp),5), " umol)"));
        xlabel("Sulfide (in M)");
        ylabel("Hydrogen (in umol)");
        plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
        #text(x,new,num2str(new',"%.4f"));
        grid on;
        hold off;

        saveas(1,strcat(model(i,:),"_S.png"));
      endif
    endfor
    pause(2);
  elseif (option == 0 || option == 4)
    #Sulfite
    pause(1);
    x = [0.01  0.025 0.05  0.1 0.3];
    base = [16 15.33333333 9 8 8.666666667 ];
    exp = [26.98305085  18.81355932 14.10169492 9.728813559 9.016949152];
    for i = 1:rows(model)
      if (exist(strcat(model(i,:),"_SO3_hour4.csv")) == 2)
        clf
        clc
        file = csvread(strcat(model(i,:),"_SO3_hour4.csv"));
        new = [mean(file(2:4,5))  mean(file(6:8,5))  mean(file(10:12,5))  mean(file(14:16,5))  mean(file(18:20,5))];

        hold on;
        title(strcat(strrep(model,"_", " ")," - Hydrogen VS Sulfite (RMSE = ", num2str(RMSE(new,exp),5), " umol)"));
        xlabel("Sulfite (in M)");
        ylabel("Hydrogen (in umol)");
        plot(x,new,"r;New Model;",x,base,"b;Base Model;",x,exp,"k;Experiment;");
        #text(x,new,num2str(new',"%.4f"));
        grid on;
        hold off;

        saveas(1,strcat(model(i,:),"_SO3.png"));
      endif
    endfor
  endif
  printf("END\n");
endfunction