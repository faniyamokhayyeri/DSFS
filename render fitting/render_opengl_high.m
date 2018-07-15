function I=render_opengl(shp,tex,tl,viewport)

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
% Load the texture
FV.color=double(tex)/255;
%  FV.textureimage=im2double(imread('lena.jpg'));
% Make texture coordinates in range [0..1]
FV.texturevertices=(FV.vertices(:,1:2)+1)/2;
% Set the material to shiny values
 FV.material=[0.5 0.5 0 1000 0];
 % Set the light position
 FV.lightposition=[-2 0 -0.2 1];
% Set the viewport
FV.viewport=viewport;
FV.enableshading=1;
FV.enabletexture=0;
FV.culling=0;
FV.enabledepthtest=1;
transm = transformmatrix(1,[pi 0 pi/2],[0 0 0]);
FV.modelviewmatrix = transm*FV.modelviewmatrix;

% Render the patch
J=renderpatch(I,FV);
%Show the RGB buffer
I=(J(:,:,1:3));