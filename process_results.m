clear all
close all
% clc

set(groot, "defaultAxesTickLabelInterpreter", "latex")
set(groot, "defaulttextInterpreter", "latex")
set(groot, "defaultLegendInterpreter","latex")

r = @( N1 , N2 , Ds ) ( N1 / N2 )^( 1 / Ds );

L1_n = 44440;
L2_n = 213928;
L3_n = 894784;

r_21 = r(L2_n , L1_n , 2);
r_32 = r(L3_n , L2_n , 2);

gci_FOS = 1.25;   % asher says this is traditionally used for GCI between three successive computational grids. will look into source for this

L1_data = readmatrix("all_resultsL1.csv");
L2_data = readmatrix("all_resultsL2.csv");
L3_data = readmatrix("all_resultsL3.csv");

L1_data(1,:) = [];
L1_data(:,1) = [];
L2_data(1,:) = [];
L2_data(:,1) = [];
L3_data(1,:) = [];
L3_data(:,1) = [];

L1_results = zeros( [18,18,4] );
L2_results = zeros( [18,18,4] );
L3_results = zeros( [18,18,4] );
gci_results = zeros( [18,18,2] );

for i = 1 : size(L1_data,1)
  L1_brick_row = L1_data(i,1);
  L1_shoe_column = L1_data(i,2);
  L1_shoe_row = L1_data(i,3);
  L1_result = L1_data(i,4);

  L2_brick_row = L2_data(i,1);
  L2_shoe_column = L2_data(i,2);
  L2_shoe_row = L2_data(i,3);
  L2_result = L2_data(i,4);

  L3_brick_row = L3_data(i,1);
  L3_shoe_column = L3_data(i,2);
  L3_shoe_row = L3_data(i,3);
  L3_result = L3_data(i,4);

  L1_results(L1_brick_row, L1_shoe_row, L1_shoe_column) = L1_result;
  L2_results(L2_brick_row, L2_shoe_row, L2_shoe_column) = L2_result;
  L3_results(L3_brick_row, L3_shoe_row, L3_shoe_column) = L3_result;

  [phi21ext, e21ext, gci21, e21abs, p] = gci( [L3_result; L2_result; L1_result] , r_32 , r_21 , gci_FOS );
  gci_results(L3_brick_row, L3_shoe_row, L3_shoe_column) = gci21 * 100;
end

min_gci = min(gci_results,[], 'all');
max_gci = max(gci_results,[], 'all');
mean_gci = mean(gci_results, 'all');
median_gci = median(gci_results, 'all');

output_path = "pdfs/";

paper_size = 8;
line_width = 1;
marker_size = 5;
line_style = "-";

marker_1 = "o";
marker_2 = "+";
marker_3 = "*";
marker_4 = "s";

color_1 = "#440154";
color_2 = "#365D8D";
color_3 = "#20A486";
color_4 = "#AADC32";

brick_surface_area = (3.92*2.09 + 3.668*2.09) * 2;
total_stack_area = brick_surface_area * 18;


%% PLOT VIEW FACTORS FROM WHOLE BRICK STACK TO EACH HOT SHOE
figure(1)
col_1_vfs = sum( L3_results( : , : , 4 ) , 1 ) * brick_surface_area / total_stack_area;
col_2_vfs = sum( L3_results( : , : , 2 ) , 1 ) * brick_surface_area / total_stack_area;
col_3_vfs = sum( L3_results( : , : , 3 ) , 1 ) * brick_surface_area / total_stack_area;
col_4_vfs = sum( L3_results( : , : , 1 ) , 1 ) * brick_surface_area / total_stack_area;
e1 = errorbar( 1:18 , col_1_vfs, sum( L3_results( : , : , 1 ) .* gci_results( : , : , 1 ), 1 ), "Marker", "o", "LineStyle", "-", "Color", color_1, "MarkerSize", marker_size, "LineWidth", line_width);
hold on
errorbar( 1:18 , col_2_vfs, sum( L3_results( : , : , 2 ) .* gci_results( : , : , 2 ), 1), "Marker", "+", "LineStyle", "-", "Color", color_2, "MarkerSize", marker_size, "LineWidth", line_width)
errorbar( 1:18 , col_3_vfs, sum( L3_results( : , : , 3 ) .* gci_results( : , : , 3 ), 1), "Marker", "*", "LineStyle", "-", "Color", color_3, "MarkerSize", marker_size, "LineWidth", line_width)
errorbar( 1:18 , col_4_vfs, sum( L3_results( : , : , 4 ) .* gci_results( : , : , 4 ), 1), "Marker", "s", "LineStyle", "-", "Color", color_4, "MarkerSize", marker_size, "LineWidth", line_width)
% set(get(e1,'Parent'), 'YScale', 'log')
xlabel("Shoe", "Interpreter", "latex")
ylabel("$F_{ij}$", "Interpreter", "latex")
legend("1", "2", "3", "4", "Interpreter", "latex", "Location", "southeast")
xlim([1,18])
xticks(1:18)
xticklabels(["1","","3","","","6","","","9","","","12","","","15","","","18"])
set(gca,"XTickLabelRotation",0)
ylim([7e-4,1.2e-3])
yticks([7e-4,8e-4,9e-4,1e-3,1.1e-3,1.2e-3])
grid on
set(gca, "FontSize", 18)
set(figure(1),'Units','centimeters')
set(figure(1),'PaperUnits','centimeters')
set(figure(1),'PaperSize',[1.1*paper_size, paper_size])
full_file_name = output_path + "whole-stack-to-all_shoes.pdf";
pause(1.5)
exportgraphics(figure(1), full_file_name)
hold off



%% PLOT VIEW FACTORS FROM EACH BRICK TO EACH HOT SHOE

for i = 1 : 18
  figure(2)
  e1 = errorbar( 1:18 , L3_results(:,i,4), L3_results(:,i,4).*gci_results(:,i,4), "Marker", marker_1, "LineStyle", line_style, "Color", color_1, "MarkerSize", marker_size, "LineWidth", line_width);
  hold on
  errorbar( 1:18 , L3_results(:,i,2), L3_results(:,i,2), L3_results(:,i,2).*gci_results(:,i,2), "Marker", marker_2, "LineStyle", line_style, "Color", color_2, "MarkerSize", marker_size, "LineWidth", line_width)
  errorbar( 1:18 , L3_results(:,i,3), L3_results(:,i,3), L3_results(:,i,3).*gci_results(:,i,3), "Marker", marker_3, "LineStyle", line_style, "Color", color_3, "MarkerSize", marker_size, "LineWidth", line_width)
  errorbar( 1:18 , L3_results(:,i,1), L3_results(:,i,1), L3_results(:,i,1).*gci_results(:,i,1), "Marker", marker_4, "LineStyle", line_style, "Color", color_4, "MarkerSize", marker_size, "LineWidth", line_width)
  set(get(e1,'Parent'), 'YScale', 'log')
  xlabel("Brick", "Interpreter", "latex")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("1", "2", "3", "4", "Interpreter", "latex")
  xlim([1,18])
  xticks(1:18)
  xticklabels(["1","","3","","","6","","","9","","","12","","","15","","","18"])
  set(gca,"XTickLabelRotation",0)
  ylim([1e-8,1e-1])
  yticks([1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1])
  grid on
  set(gca, "FontSize", 18)
  set(figure(2),'Units','centimeters')
  set(figure(2),'PaperUnits','centimeters')
  set(figure(2),'PaperSize',[1.1*paper_size, paper_size])
  full_file_name = output_path + "bricks-to-shoes-row-" + num2str(i) + ".pdf";
  pause(1.5)
  exportgraphics(figure(2), full_file_name)
  hold off


  figure(3)
  e1 = errorbar( 1:18 , L3_results(i,:,4), L3_results(i,:,4).*gci_results(i,:,4) , "Marker", marker_1, "LineStyle", line_style, "Color", color_1, "MarkerSize", marker_size, "LineWidth", line_width);
  hold on
  errorbar( 1:18 , L3_results(i,:,2), L3_results(i,:,2).*gci_results(i,:,2) ,"Marker", marker_2, "LineStyle", line_style, "Color", color_2, "MarkerSize", marker_size, "LineWidth", line_width)
  errorbar( 1:18 , L3_results(i,:,3), L3_results(i,:,3).*gci_results(i,:,3), "Marker", marker_3, "LineStyle", line_style, "Color", color_3, "MarkerSize", marker_size, "LineWidth", line_width)
  errorbar( 1:18 , L3_results(i,:,1), L3_results(i,:,1).*gci_results(i,:,1), "Marker", marker_4, "LineStyle", line_style, "Color", color_4, "MarkerSize", marker_size, "LineWidth", line_width)
  set(get(e1,'Parent'), 'YScale', 'log')
  xlabel("Shoe", "Interpreter", "latex")
  ylabel("$F_{ij}$", "Interpreter", "latex")
  legend("1", "2", "3", "4", "Interpreter", "latex")
  xlim([1,18])
  xticks(1:18)
  xticklabels(["1","","3","","","6","","","9","","","12","","","15","","","18"])
  set(gca,"XTickLabelRotation",0)
  ylim([1e-8,1e-1])
  yticks([1e-8,1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1])
  grid on
  set(gca, "FontSize", 18)
  set(figure(3),'Units','centimeters')
  set(figure(3),'PaperUnits','centimeters')
  set(figure(3),'PaperSize',[1.1*paper_size, paper_size])
  full_file_name = output_path + "brick-" + num2str(i) + "-shoes.pdf";
  pause(1.5)
  exportgraphics(figure(3), full_file_name)
  hold off

end