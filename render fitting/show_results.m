clc
clear all
close all
load render_results

% mex renderpatch.cpp -v
% mex patchshadowvolume.cpp -v
% mex patchnormals_double.c -v

I_desired= imread('desired_image_points.jpg');

[model msz] = load_model();

f_2D=figure;
f_2D.Position=[50 300 500 500];
imshow(I_desired);
%**************************************************************************
%**************************************************************************
%**************************************************************************
alpha=x(1:199)';
beta=x(199+1:199*2)';
viewport=[-50 -50 500 500];
shape  = coef2object_mex( alpha, model.shapeMU, model.shapePC, model.shapeEV );
texture    = coef2object_mex( beta,  model.texMU,   model.texPC,   model.texEV );
tl=model.tl;
shp = reshape(shape, [ 3 prod(size(shape))/3 ])';
tex = reshape(texture, [ 3 prod(size(texture))/3 ])';
tex = min(tex, 255);

%**************************************************************************
%**************************************************************************
%**************************************************************************

I = zeros (500,500,6);
I(:,:,5)=1; % Background depth
% Load Patch object
FV.vertices=double(shp);
FV.faces=double(tl);
% Transform coordinates to [-1..1] range
FV.vertices = FV.vertices-mean(FV.vertices(:));
FV.vertices =FV.vertices ./max(FV.vertices(:));
% Calculate the normals
FV.normals=patchnormals(FV);
% Set the ModelViewMatrix
FV.modelviewmatrix=[1 0 0 0; 0 1 0 0;0 0 1 0; 0 0 0 1];
FV.textureimage=im2double(imread('texture_image.jpg'));
for i=1:size(tex,1)
    tex(i,:)=tex(i,:)+[30 20 0];
end

FV.color=double(tex)/255*1;
% FV.textureimage=im2double(imread('lena.jpg'));
% Make texture coordinates in range [0..1]
FV.texturevertices=(FV.vertices(:,1:2)+1)/2;
% Set the material to shiny values
FV.material=[0.9 0.5 0 1 0];
% Set the light position
FV.lightposition=[-2 0 -0.2 1];
% Set the viewport
FV.viewport=viewport;
FV.enableshading=1;
FV.enabletexture=1;
FV.culling=0;
FV.enabledepthtest=1;
transm = transformmatrix(1,[pi 0 pi/2],[0 0 0]);
FV.modelviewmatrix = transm*FV.modelviewmatrix;

J=renderpatch(I,FV); 
%Show the RGB buffer

f_3D=figure;
f_3D.Position=[800 300 500 500];
h=imshow(J(:,:,1:3));

% Rotate the object slowly while showing the render result
  for i=1:1000
%      pause(0.2)
    transm = transformmatrix(1,[0.05 0 0],[0 0 0]);
    FV.modelviewmatrix = transm*FV.modelviewmatrix;
    J=renderpatch(I,FV); set(h,'CData',J(:,:,1:3)); drawnow('expose');
 end
 