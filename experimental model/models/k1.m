cat_size = 2;
sulfur_size = 1; 
side = 70;
volume = side^3;
cat = fliplr(0:400)';
HS2 = [zeros(1, rows(cat)-2), 1, 2]';
K1 = 28*(1-25*((cat*(4*pi*(cat_size^3)/6)+HS2*(4*pi*(sulfur_size^3)/6))/volume));
K1(1)