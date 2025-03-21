clear all
close all
clc

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

output_path = "pdfs/";

paper_size = 12;

line_width = 1;
marker_size = 5;

for i = 1 : 18
  semilogy( 1:18 , results(:,i,3), "*:b", "MarkerSize", marker_size, "LineWidth", line_width)
  hold on
  semilogy( 1:18 , results(:,i,4), "s:m", "MarkerSize", marker_size, "LineWidth", line_width)
  semilogy( 1:18 , results(:,i,2) , "+:r", "MarkerSize", marker_size, "LineWidth", line_width)
  semilogy( 1:18 , results(:,i,1) , "o:k", "MarkerSize", marker_size, "LineWidth", line_width)
  grid on
  xlabel("Brick", "Interpreter", "latex")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("col 3", "col 4", "col 2", "col 1", "Interpreter", "latex")
  xlim([1,18])
  xticks([1,9,18])
  xticklabels([1,9,18])
  ylim([1e-8, 1e-1])
  yticks([1e-8, 1e-6, 1e-3, 1e-1])
  title_text = "Bricks to row (" + num2str(i) + ") Shoes";
  title( title_text , "Interpreter", "latex" )
  set(gca, "FontSize", 18)


  set(gcf,'Units','centimeters')
  set(gcf,'PaperUnits','centimeters')
  set(gcf,'PaperSize',[paper_size paper_size])
  set(gcf,'PaperOrientation','portrait')
  set(gcf,'InnerPosition',[0,0,paper_size-1,paper_size-1])
  % set(gcf,'OuterPosition',[0.5,0.5,paper_size-1.5,paper_size-1.5])
  % set(gcf,'PaperPosition',[0,0, paper_size-1.25, paper_size-1.25])
  
  
  % oldunits = get(gcf, 'Units');
  % set(gcf, 'PaperUnits', 'centimeters', 'Units', 'centimeters');
  % figpos = get(gcf, 'Position');
  % set(gcf, 'PaperSize', figpos(3:4), 'Units', oldunits);

  % annotation('rectangle', [0,0,1,1], 'Color', 'red')

  hold off
  full_file_name = output_path + "bricks-to-shoes-row-" + num2str(i) + ".pdf";
  print(full_file_name, '-dpdf', '-r2400');
end


for i = 1 : 18
  plot( 1:18 , results(i,:,1) , "o:k", "MarkerSize", marker_size, "LineWidth", line_width)
  hold on
  plot( 1:18 , results(i,:,2) , "o--k", "MarkerSize", marker_size, "LineWidth", line_width, "MarkerFaceColor", "k")
  plot( 1:18 , results(i,:,3), "s:k", "MarkerSize", marker_size, "LineWidth", line_width)
  plot( 1:18 , results(i,:,4), "s--k", "MarkerSize", marker_size, "LineWidth", line_width, "MarkerFaceColor", "k")
  grid on
  xlabel("Shoe", "Interpreter", "latex")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("x-y", "left", "right", "y-z", "Interpreter", "latex")
  xlim([1,18])
  if i < 10
    ylim([0,0.015])
  end
  title_text = "Brick (" + num2str(i) + ") to all Shoes";
  title( title_text , "Interpreter", "latex" )
  set(gca, "FontSize", 18)
  set(gcf,'PaperUnits','centimeters')
  set(gcf,'PaperSize',[paper_size paper_size])
  set(gcf,'PaperPosition',[0 0 paper_size paper_size])
  set(gcf,'PaperOrientation','portrait')
  hold off
  full_file_name = output_path + "brick-" + num2str(i) + "-to-shoes.pdf";
  print(full_file_name, '-dpdf', '-r2400');
end