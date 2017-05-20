function err = RMSE(A,B)

  n = max(size(A));
  
  #Square
  for i = 1:n
    square(i) = (A(i) - B(i))^2;
  endfor
  
  #Mean
  err = sum(square)/n;

  #Root
  err = sqrt(err);
endfunction