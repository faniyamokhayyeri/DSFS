function main
clc
close all
clear
global model Data_desired finded_points_list a1 a2 b1 b2
[model msz] = load_model();
Data_desired=load('2D_points.txt');
load coefs
a1=Coef1(1);b1=Coef1(2);
a2=Coef2(1);b2=Coef2(2);

load finded_points_list;
lb = [ones(199,1)*-5; 1; 1; 1; 1];
ub = [ones(199,1)*5; 1; 1; 1; 1];
% x0=ones(199,1)*0.01;
% options=optimoptions('particleswarm','Display','iter')
options=gaoptimset('Display','iter','Generations',1000);%,'UseParallel', true, 'Vectorized', 'off');
[x,fval,exitflag] = ga(@fit_func,203,[],[],[],[],lb,ub,[],[],options)
% x=particleswarm(@fit_func,199,lb,ub,options)
save results
alpha=x(1:199); beta=zeros(199,1);
 model2image(model, alpha' , beta);

function f=fit_func(x)
global model Data_desired finded_points_list a1 a2 b1 b2
alpha=x(1:199);
a1p=x(200);b1p=x(201);
a2p=x(202);b2p=x(203);
shape  = coef2object_mex( alpha', model.shapeMU, model.shapePC, model.shapeEV );
shp = reshape(shape, [ 3 prod(size(shape))/3 ])';
ss=0;
for i=1:size(finded_points_list,2)
    current_2D(1)=(shp(finded_points_list{i}(1,4),1)-(b1*b1p))/(a1*a1p);
    current_2D(2)=(shp(finded_points_list{i}(1,4),2)-(b2*b2p))/(a2*a2p);
    ss=ss+norm(current_2D-Data_desired(i,:));
end

f=double(ss+sum(alpha.^2)*1);

