clear all
close all
clc

set(groot, "defaultAxesTickLabelInterpreter", "latex")
set(groot, "defaulttextInterpreter", "latex")
set(groot, "defaultLegendInterpreter","latex")

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
line_style = "-";
plot_aspect_ratio = [1,1,1];

marker_1 = "o";
marker_2 = "+";
marker_3 = "*";
marker_4 = "s";



% THIS PART IS WEIRD BUT I WAS HAVING ISSUES WITH THE FIRST FIGURE BEING THE WRONG SIZE AND INITIALIZING THIS FIGURE HELPS

i = 1;

semilogy( 1:18 , results(:,i,1), "Marker", marker_1, "LineStyle", line_style, "Color", [1,0,0], "MarkerSize", marker_size, "LineWidth", line_width)
hold on
semilogy( 1:18 , results(:,i,2), "Marker", marker_2, "LineStyle", line_style, "Color", [1,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
semilogy( 1:18 , results(:,i,3), "Marker", marker_3, "LineStyle", line_style, "Color", [0,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
semilogy( 1:18 , results(:,i,4), "Marker", marker_4, "LineStyle", line_style, "Color", [0,1,0], "MarkerSize", marker_size, "LineWidth", line_width)
xlabel("Brick", "Interpreter", "latex")
ylabel("$F_{ij}$", "Interpreter", "latex")
legend("col 1", "col 2", "col 3", "col 4", "Interpreter", "latex")
xlim([1,18])
xticks(1:18)
xticklabels(["1","","3","","","6","","","9","","","12","","","15","","","18"])
set(gca, "XTickLabelRotation", 0)
ylim([1e-8, 1e-1])
yticks([1e-8, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1])
yticklabels(["1e-8", "", "1e-6", "", "1e-4", "", "1e-2", "1e-1"])
pbaspect(plot_aspect_ratio)
grid on
set(gca, "FontSize", 18)
set(gcf,'Units','centimeters')
set(gcf,'PaperUnits','centimeters')
set(gcf,'PaperSize',[paper_size, paper_size])
% set(gcf,'InnerPosition',[0.5,0.5,paper_size-1,paper_size-1])
set(gcf,'OuterPosition',[0.1,0.1,paper_size-0.2,paper_size-0.2])
set(gcf,'PaperPosition',[0,0, paper_size, paper_size])

hold off




for i = 1 : 18
  semilogy( 1:18 , results(:,i,1), "Marker", marker_1, "LineStyle", line_style, "Color", [1,0,0], "MarkerSize", marker_size, "LineWidth", line_width)
  hold on
  semilogy( 1:18 , results(:,i,2), "Marker", marker_2, "LineStyle", line_style, "Color", [1,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  semilogy( 1:18 , results(:,i,3), "Marker", marker_3, "LineStyle", line_style, "Color", [0,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  semilogy( 1:18 , results(:,i,4), "Marker", marker_4, "LineStyle", line_style, "Color", [0,1,0], "MarkerSize", marker_size, "LineWidth", line_width)
  xlabel("Brick", "Interpreter", "latex")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("col 1", "col 2", "col 3", "col 4", "Interpreter", "latex")
  xlim([1,18])
  xticks(1:18)
  xticklabels(["1","","3","","","6","","","9","","","12","","","15","","","18"])
  set(gca, "XTickLabelRotation", 0)
  ylim([1e-8, 1e-1])
  yticks([1e-8, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1])
  yticklabels(["1e-8", "", "1e-6", "", "1e-4", "", "1e-2", "1e-1"])
  pbaspect(plot_aspect_ratio)
  set(gca, "FontSize", 18)
  grid on
  set(gcf,'Units','centimeters')
  set(gcf,'PaperUnits','centimeters')
  set(gcf,'PaperSize',[paper_size, paper_size])
  % set(gcf,'InnerPosition',[0.5,0.5,paper_size-1,paper_size-1])
  set(gcf,'OuterPosition',[0.1,0.1,paper_size-0.2,paper_size-0.2])
  set(gcf,'PaperPosition',[0,0, paper_size, paper_size])

  hold off
  full_file_name = output_path + "bricks-to-shoes-row-" + num2str(i) + ".pdf";
  exportgraphics(gcf, full_file_name)



  semilogy( 1:18 , results(i,:,1) , "Marker", marker_1, "LineStyle", line_style, "Color", [1,0,0], "MarkerSize", marker_size, "LineWidth", line_width)
  hold on
  semilogy( 1:18 , results(i,:,2) ,"Marker", marker_2, "LineStyle", line_style, "Color", [1,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  semilogy( 1:18 , results(i,:,3), "Marker", marker_3, "LineStyle", line_style, "Color", [0,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  semilogy( 1:18 , results(i,:,4), "Marker", marker_4, "LineStyle", line_style, "Color", [0,1,0], "MarkerSize", marker_size, "LineWidth", line_width)
  xlabel("Shoe", "Interpreter", "latex")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("col 1", "col 2", "col 3", "col 4", "Interpreter", "latex")
  xlim([1,18])
  xticks(1:18)
  xticklabels(["1","","3","","","6","","","9","","","12","","","15","","","18"])
  set(gca, "XTickLabelRotation", 0)
  ylim([1e-8, 1e-1])
  yticks([1e-8, 1e-7, 1e-6, 1e-5, 1e-4, 1e-3, 1e-2, 1e-1])
  yticklabels(["1e-8", "", "1e-6", "", "1e-4", "", "1e-2", "1e-1"])
  pbaspect(plot_aspect_ratio)
  set(gca, "FontSize", 18)
  grid on
  set(gcf,'Units','centimeters')
  set(gcf,'PaperUnits','centimeters')
  set(gcf,'PaperSize',[paper_size, paper_size])
  % set(gcf,'InnerPosition',[0.5,0.5,paper_size-1,paper_size-1])
  set(gcf,'OuterPosition',[0.1,0.1,paper_size-0.2,paper_size-0.2])
  set(gcf,'PaperPosition',[0,0, paper_size, paper_size])
  hold off
  full_file_name = output_path + "brick-" + num2str(i) + "-to-shoes.pdf";
  exportgraphics(gcf, full_file_name)

end













% % figure(2)
  % semilogy( range_1 , results(range_1,i,1), "o", "LineStyle", line_style, "Color", [1,0,0], "MarkerSize", marker_size, "LineWidth", line_width)
  % hold on
  % semilogy( range_1 , results(range_1,i,2) , "+", "LineStyle", line_style, "Color", [1,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  % semilogy( range_1 , results(range_1,i,3), "*", "LineStyle", line_style, "Color", [0,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  % semilogy( range_1 , results(range_1,i,4), "s", "LineStyle", line_style, "Color", [0,1,0], "MarkerSize", marker_size, "LineWidth", line_width)
  % xlabel("Brick", "Interpreter", "latex")
  % ylabel("$F_{ij}$", "Interpreter", "latex")
  % legend("col 1", "col 2", "col 3", "col 4", "Interpreter", "latex")
  % xlim([1,5])
  % xticks([1,3,5])
  % xticklabels([1,3,5])
  % ylim([1e-8, 1e-1])
  % yticks([1e-8, 1e-6, 1e-3, 1e-1])
  % pbaspect(plot_aspect_ratio)
  % grid on
  % % title_text = "Bricks to row (" + num2str(i) + ") Shoes";
  % % title( title_text , "Interpreter", "latex" )
  % set(gca, "FontSize", 18)
  % hold off
  % full_file_name = output_path + "bricks-to-shoes-row-" + num2str(i) + "-bricks-" + num2str(range_1(1)) + "-" + num2str(range_1(end)) + ".pdf";
  % % print(full_file_name, '-dpdf', '-r2400');
  % exportgraphics(gcf, full_file_name)
  % 
  % 
  % 
  % 
  % % figure(3)
  % semilogy( range_2 , results(range_2,i,1), "o", "LineStyle", line_style, "Color", [1,0,0], "MarkerSize", marker_size, "LineWidth", line_width)
  % hold on
  % semilogy( range_2 , results(range_2,i,2) , "+", "LineStyle", line_style, "Color", [1,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  % semilogy( range_2 , results(range_2,i,3), "*", "LineStyle", line_style, "Color", [0,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  % semilogy( range_2 , results(range_2,i,4), "s", "LineStyle", line_style, "Color", [0,1,0], "MarkerSize", marker_size, "LineWidth", line_width)
  % xlabel("Brick", "Interpreter", "latex")
  % ylabel("$F_{ij}$", "Interpreter", "latex")
  % legend("col 1", "col 2", "col 3", "col 4", "Interpreter", "latex")
  % xlim([range_2(1), range_2(end)])
  % xticks([range_2(1), range_2(floor(length(range_2)/2)) range_2(end)])
  % ylim([1e-8, 1e-1])
  % yticks([1e-8, 1e-6, 1e-3, 1e-1])
  % pbaspect(plot_aspect_ratio)
  % grid on
  % % title_text = "Bricks to row (" + num2str(i) + ") Shoes";
  % % title( title_text , "Interpreter", "latex" )
  % set(gca, "FontSize", 18)
  % hold off
  % full_file_name = output_path + "bricks-to-shoes-row-" + num2str(i) + "-bricks-" + num2str(range_2(1)) + "-" + num2str(range_2(end)) + ".pdf";
  % % print(full_file_name, '-dpdf', '-r2400');
  % exportgraphics(gcf, full_file_name)
  % 
  % 
  % 
  % 
  % % figure(4)
  % semilogy( range_3 , results(range_3,i,1), "o", "LineStyle", line_style, "Color", [1,0,0], "MarkerSize", marker_size, "LineWidth", line_width)
  % hold on
  % semilogy( range_3 , results(range_3,i,2) , "+", "LineStyle", line_style, "Color", [1,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  % semilogy( range_3 , results(range_3,i,3), "*", "LineStyle", line_style, "Color", [0,0,1], "MarkerSize", marker_size, "LineWidth", line_width)
  % semilogy( range_3 , results(range_3,i,4), "s", "LineStyle", line_style, "Color", [0,1,0], "MarkerSize", marker_size, "LineWidth", line_width)
  % xlabel("Brick", "Interpreter", "latex")
  % ylabel("$F_{ij}$", "Interpreter", "latex")
  % legend("col 1", "col 2", "col 3", "col 4", "Interpreter", "latex")
  % xlim([range_3(1), range_3(end)])
  % xticks([range_3(1), range_3(ceil(length(range_3)/2)) range_3(end)])
  % ylim([1e-8, 1e-1])
  % yticks([1e-8, 1e-6, 1e-3, 1e-1])
  % pbaspect(plot_aspect_ratio)
  % grid on
  % % title_text = "Bricks to row (" + num2str(i) + ") Shoes";
  % % title( title_text , "Interpreter", "latex" )
  % set(gca, "FontSize", 18)
  % hold off
  % full_file_name = output_path + "bricks-to-shoes-row-" + num2str(i) + "-bricks-" + num2str(range_3(1)) + "-" + num2str(range_3(end)) + ".pdf";
  % % print(full_file_name, '-dpdf', '-r2400');
  % exportgraphics(gcf, full_file_name)