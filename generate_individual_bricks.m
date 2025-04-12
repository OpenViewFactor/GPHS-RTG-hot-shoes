clear all
clc

EXPORT_TOGGLE = true;
GRAPH_TOGGLE = false;

STEP_TYPE = 'step1';

addpath("submodules\distmesh-utilities\")

%* --------------- BRICK PARAMETERS --------------- *%
GPHS_WIDTH_x = 3.92;            % [in]
GPHS_DEPTH_y = 3.668;           % [in]
%! ----- set brick type settings ----- !%
if strcmpi(STEP_TYPE, 'step1')
  GPHS_HEIGHT_z = 2.09;         % [in]
  GPHS_STACK_COUNT = 18;
  STEP1 = true; STEP2 = false;
elseif strcmpi(STEP_TYPE, 'step2')
  GPHS_HEIGHT_z = 2.29;         % [in]
  GPHS_STACK_COUNT = 16;
  STEP1 = false; STEP2 = true;
end

assets_path = "assets/bricks/";


refinement_levels = [ 101 , 221 , 451 ];

for i = 1 : 3
  
  output_path = assets_path + "L" + num2str(i) + "/";
  
  num_divisions = refinement_levels(i);
  x_z_negative_y_face_mesh = translateMesh( translateMesh( rotateMesh( generateRectangle2( GPHS_WIDTH_x , GPHS_HEIGHT_z , num_divisions ) , pi/2 , 1 ) , [ -0.5 * GPHS_WIDTH_x , 0 , 0 ] ) , [ 0 , -0.5 * GPHS_DEPTH_y , 0] );
  x_z_positive_y_face_mesh = flipMeshAboutPlane( x_z_negative_y_face_mesh , [ 0 , 0 , 0 ] , [ 0 , 1 , 0 ] );

  y_z_negative_x_face_mesh = translateMesh( translateMesh( rotateMesh( rotateMesh( generateRectangle2( GPHS_DEPTH_y , GPHS_HEIGHT_z , num_divisions ) , pi/2 , 1 ) , pi/2 , 3 ) , [ 0 , -0.5 * GPHS_DEPTH_y , 0] ) , [ 0.5 * GPHS_WIDTH_x , 0 , 0] );
  y_z_positive_x_face_mesh = flipMeshAboutPlane( y_z_negative_x_face_mesh , [ 0 , 0 , 0 ] , [ 1 , 0 , 0 ] );

  %* --------------- PACKAGE THE MESHES --------------- *%
  GPHS_bricks_mesh_points = [x_z_positive_y_face_mesh.Points;...
      x_z_negative_y_face_mesh.Points;...
      y_z_positive_x_face_mesh.Points;...
      y_z_negative_x_face_mesh.Points];
  GPHS_bricks_mesh_connectivity = [x_z_positive_y_face_mesh.ConnectivityList;...
      x_z_negative_y_face_mesh.ConnectivityList + (size(x_z_positive_y_face_mesh.Points, 1));...
      y_z_positive_x_face_mesh.ConnectivityList + (size(x_z_positive_y_face_mesh.Points, 1) +...
                                                  size(x_z_negative_y_face_mesh.Points, 1));...
      y_z_negative_x_face_mesh.ConnectivityList + (size(x_z_positive_y_face_mesh.Points, 1) +...
                                                  size(x_z_negative_y_face_mesh.Points, 1) +...
                                                  size(y_z_positive_x_face_mesh.Points, 1))];

  %* --------------- FILTER FOR UNIQUE POINTS --------------- *%
  [GPHS_bricks_mesh_points, ~, IC] = unique(GPHS_bricks_mesh_points, 'rows', 'stable');
  GPHS_bricks_mesh_connectivity = IC(GPHS_bricks_mesh_connectivity);
  %* --------------- STORE THE TRIANGULATION --------------- *%
  GPHS_bricks_mesh = triangulation(GPHS_bricks_mesh_connectivity, GPHS_bricks_mesh_points);
  GPHS_bricks_mesh = translateMesh( GPHS_bricks_mesh , [ 0 , 0 , -GPHS_STACK_COUNT/2 * GPHS_HEIGHT_z ] );

  %* --------------- DUPLICATE BRICKS VERTICALLY --------------- *%
  BRICK_meshes = cell(GPHS_STACK_COUNT,1);
  BRICK_meshes{GPHS_STACK_COUNT, 1} = GPHS_bricks_mesh;

  for j = 1 : (GPHS_STACK_COUNT) - 1
    BRICK_meshes{GPHS_STACK_COUNT - j, 1} = translateMesh(GPHS_bricks_mesh, [0, 0, j*(GPHS_HEIGHT_z)]);
  end

  %* --------------- EXPORT MESHES --------------- *%
  if EXPORT_TOGGLE
    for j = 1 : GPHS_STACK_COUNT
        stlwrite(BRICK_meshes{j, 1}, output_path + "GPHS_brick-row-" + num2str(j) + ".stl", "binary")
    end
  end

end

%* --------------- PLOT MESHES --------------- *%
if GRAPH_TOGGLE
  
  % figure
  hold on
  for i = 1 : GPHS_STACK_COUNT
    trisurf(BRICK_meshes{i, 1},'EdgeColor','none','FaceColor','b','FaceAlpha',0.5)
  end
  pbaspect([1,1,1])
  daspect([1,1,1])
  xlabel('x')
  ylabel('y')
  zlabel('z')
  view(3)
  hold off

end