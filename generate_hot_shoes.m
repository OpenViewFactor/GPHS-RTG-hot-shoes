EXPORT_TOGGLE = true;
GRAPH_TOGGLE = false;

output_path = "assets/hot-shoes/";

%* --------------- SHOE PARAMETERS --------------- *%
SHOE_SIZE = 0.9;              % [in]
VERT_SPACING = 0.145;         % [in]
HORIZ_SPACING = 0.1;          % [in]
CENTER_OFFSET = 3.01;         % [in]
DIAG_OFFSET = [0.507, -0.21];  % [in]
SHOE_STACK_COUNT = 18;

NUM_DIVISIONS = 21;

%* --------------- GENERATE HOT SHOES --------------- *%
%! generate hot shoe face parallel to the x-z plane
yz_positive_x_face_mesh = translateMesh( translateMesh( translateMesh( rotateMesh( generateRectangle2( SHOE_SIZE , SHOE_SIZE , NUM_DIVISIONS ) , pi/2 , 2 ) , [ CENTER_OFFSET , 0 , 0 ] ) , [ 0 , HORIZ_SPACING , 0 ] ) , [ 0 , 0 , VERT_SPACING / 2 ] );
left_diagonal_face_mesh = rotateMesh( yz_positive_x_face_mesh , pi/4 , 3 );
right_diagonal_face_mesh = flipMeshAboutPlane( left_diagonal_face_mesh , [ 0 , 0 ,0 ] , [ 1 , -1 , 0 ] ./ norm([ 1 , -1 , 0 ]) );
xz_positive_y_face_mesh = rotateMesh( right_diagonal_face_mesh , pi/4 , 3 );

%* --------------- DUPLICATE HOT SHOES VERTICALLY --------------- *%
SHOE_meshes = cell(SHOE_STACK_COUNT,4);
SHOE_meshes{SHOE_STACK_COUNT, 1} = xz_positive_y_face_mesh;
SHOE_meshes{SHOE_STACK_COUNT, 2} = left_diagonal_face_mesh;
SHOE_meshes{SHOE_STACK_COUNT, 3} = right_diagonal_face_mesh;
SHOE_meshes{SHOE_STACK_COUNT, 4} = yz_positive_x_face_mesh;

for i = 1 : (SHOE_STACK_COUNT) - 1
  SHOE_meshes{SHOE_STACK_COUNT - i, 1} = translateMesh(xz_positive_y_face_mesh, [0, 0, i*(SHOE_SIZE + VERT_SPACING)]);
  SHOE_meshes{SHOE_STACK_COUNT - i, 2} = translateMesh(left_diagonal_face_mesh, [0, 0, i*(SHOE_SIZE + VERT_SPACING)]);
  SHOE_meshes{SHOE_STACK_COUNT - i, 3} = translateMesh(right_diagonal_face_mesh, [0, 0, i*(SHOE_SIZE + VERT_SPACING)]);
  SHOE_meshes{SHOE_STACK_COUNT - i, 4} = translateMesh(yz_positive_x_face_mesh, [0, 0, i*(SHOE_SIZE + VERT_SPACING)]);
end

%* --------------- EXPORT MESHES --------------- *%
if EXPORT_TOGGLE
  for i = 1 : SHOE_STACK_COUNT
      stlwrite(SHOE_meshes{i, 1}, output_path + "x_z_positive_y_face-row-" + num2str(i) + ".stl", "binary")
      stlwrite(SHOE_meshes{i, 2}, output_path + "left_diagonal_face-row-" + num2str(i) + ".stl", "binary")
      stlwrite(SHOE_meshes{i, 3}, output_path + "right_diagonal_face-row-" + num2str(i) + ".stl", "binary")
      stlwrite(SHOE_meshes{i, 4}, output_path + "y_z_positive_x_face-row-" + num2str(i) + ".stl", "binary")
  end
end

%* --------------- PLOT MESHES --------------- *%
if GRAPH_TOGGLE
  
  figure
  hold on
  for i = 1 : SHOE_STACK_COUNT
    trisurf(SHOE_meshes{i, 1},'EdgeColor','none','FaceColor','red','FaceAlpha',0.5)
    trisurf(SHOE_meshes{i, 2},'EdgeColor','none','FaceColor','red','FaceAlpha',0.5)
    trisurf(SHOE_meshes{i, 3},'EdgeColor','none','FaceColor','red','FaceAlpha',0.5)
    trisurf(SHOE_meshes{i, 4},'EdgeColor','none','FaceColor','red','FaceAlpha',0.5)
  end
  pbaspect([1,1,1])
  daspect([1,1,1])
  xlabel('x')
  ylabel('y')
  zlabel('z')
  view(3)
  hold off

end