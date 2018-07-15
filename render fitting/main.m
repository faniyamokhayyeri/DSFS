function Main
clc
close all
load results
lb = [x(1:199)-abs(x(1:199))*0.01 ones(1,199)*-5  -23 -23 100 100];
ub = [x(1:199)+abs(x(1:199))*0.01 ones(1,199)*5   -10  -5  130 130];
clear x

mex renderpatch.cpp -v
mex patchshadowvolume.cpp -v
mex patchnormals_double.c -v
I_desired= imread('desired_image.jpg');

[model msz] = load_model();
model_shapeMU=model.shapeMU;
model_shapePC=model.shapePC;
model_shapeEV=model.shapeEV;

model_texMU=model.texMU;
model_texPC=model.texPC;
model_texEV=model.texEV;
tl=model.tl;
%  figure, h=imshow(I_desired);
%**************************************************************************
%**************************************************************************
%**************************************************************************
% alpha=rand(1,199)';
% beta=rand(1,199)';
% viewport=[-10 -5 100 100];
% shape  = coef2object_mex( alpha, model.shapeMU, model.shapePC, model.shapeEV );
% texture    = coef2object_mex( beta,  model.texMU,   model.texPC,   model.texEV );
% tl=model.tl;
% shp = reshape(shape, [ 3 prod(size(shape))/3 ])';
% tex = reshape(texture, [ 3 prod(size(texture))/3 ])';
% tex = min(tex, 255);
% I=render_opengl(shp,tex,tl,viewport);
% figure, h=imshow(I);
%**************************************************************************
%**************************************************************************
%**************************************************************************
clc
options=gaoptimset('Display','iter','Generations',90);
[x,fval,exitflag] = ga(@(x)fit_func(x, model_shapeMU, model_shapePC, model_shapeEV, model_texMU, model_texPC, model_texEV, I_desired, tl),(199*2+4),[],[],[],[],lb,ub,[],options)
save render_results
%**************************************************************************
%**************************************************************************
%**************************************************************************
alpha=x(1:199)';
beta=x(200:199*2)';
viewport=x(199*2+1:199*2+4);
shape  = coef2object_mex( alpha, model.shapeMU, model.shapePC, model.shapeEV );
texture    = coef2object_mex( beta,  model.texMU,   model.texPC,   model.texEV );
tl=model.tl;
shp = reshape(shape, [ 3 prod(size(shape))/3 ])';
tex = reshape(texture, [ 3 prod(size(texture))/3 ])';
tex = min(tex, 255);
Is=render_opengl(shp,tex,tl,viewport);
figure, h=imshow(Is);

%**************************************************************************
%**************************************************************************
%**************************************************************************
function f=fit_func(x, model_shapeMU, model_shapePC, model_shapeEV, model_texMU, model_texPC, model_texEV, I_desired, tl)

alpha=x(1:199)';
beta=x(200:199*2)';
viewport=x(199*2+1:199*2+4);
shape  = coef2object_mex( alpha, model_shapeMU, model_shapePC, model_shapeEV );
texture    = coef2object_mex( beta,  model_texMU,   model_texPC,   model_texEV );

shp = reshape(shape, [ 3 prod(size(shape))/3 ])';
tex = reshape(texture, [ 3 prod(size(texture))/3 ])';
tex = min(tex, 255);
Is=render_opengl(shp,tex,tl,viewport);
% f=0;
f=sum(sum(sum((double(Is)-double(I_desired)).^2)));
% for i=1:100
%     for j=1:100
%         if (I_desired(i,j,1))>10||(I_desired(i,j,2))>10||(I_desired(i,j,2))>10
%             f=sum( ( double(Is(i,j,:))-double(I_desired(i,j,:)) ).^2)+f;
%         end
%     end
% end


