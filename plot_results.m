data = readmatrix("all_results.csv");
data(1,:) = [];
data(:,1) = [];

results = zeros( [18,18,4] );

for i = 1 : size(data,1)
  brick_row = data(i,1);
  shoe_column = data(i,2);
  shoe_row = data(i,3);
  result = data(i,4);

  results(brick_row, shoe_row, shoe_column) = result;
end


for i = 1 : 18
  figure(i)
  plot( 1:18 , results(:,i,1) , "o:k", "MarkerSize", 10, "LineWidth", 3)
  hold on
  plot( 1:18 , results(:,i,2) , "o--k", "MarkerSize", 10, "MarkerFaceColor", "k", "LineWidth", 3)
  plot( 1:18 , results(:,i,3), "s:k", "MarkerSize", 10, "LineWidth", 3)
  plot( 1:18 , results(:,i,4), "s--k", "MarkerSize", 10, "MarkerFaceColor", "k", "LineWidth", 3)
  grid on
  xlabel("Brick")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("x-y", "left", "right", "y-z")
  xlim([1,18])
  set(gca, "FontSize", 18)
  set(gcf,'PaperUnits','centimeters')
  set(gcf,'PaperSize',[10 10])
  set(gcf,'PaperPosition',[0 0 10 10])
  set(gcf,'PaperOrientation','portrait')
  hold off
end