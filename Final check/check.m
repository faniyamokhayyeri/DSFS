
clc
close all

[model msz] = load_model();

I_desired=imread('desired_image.jpg');

clc
close
f_2D = figure;
imshow(I_desired,'Border','tight');
f_2D.Units='pixels';
f_2D.Pointer='cross';
f_2D.MenuBar='none';
% f_2D.WindowStyle='modal';
f_2D.Resize='off';
hold on
xlim([0 size(I_desired,1)]);ylim([0 size(I_desired,2)])
f_2D.Position=[150 150 500 500];

%**************************************************************************
%**************************************************************************
[model msz] = load_model();
load results

alpha_sample=x(1:199)';
beta_sample=zeros(199,1);
figure
I_default=model2image(model , alpha_sample , beta_sample);
clc
close
f_3D=figure;
imshow(I_default,'Border','tight');
f_3D.MenuBar='none';
f_3D.Resize='off';
f_3D.Position=[720 150 500 500];


%**************************************************************************
%**************************************************************************
Data_2D=load('2D_points.txt')

figure(f_2D)
hold on
for i=1:size(Data_2D,1)
    plot(Data_2D(i,1),Data_2D(i,2),'r+');
    text(Data_2D(i,1),Data_2D(i,2)-4, num2str(i),'Color','b')
end

%**************************************************************************
%**************************************************************************
load coefs
a1=Coef1(1);b1=Coef1(2);
a2=Coef2(1);b2=Coef2(2);
alpha=x(1:199);
a1p=x(200);b1p=x(201);
a2p=x(202);b2p=x(203);
shape  = coef2object( alpha', model.shapeMU, model.shapePC, model.shapeEV );
shp = reshape(shape, [ 3 prod(size(shape))/3 ])';

%**************************************************************************
%**************************************************************************
load finded_points_list
figure(f_3D)
hold on
for i=1:size(finded_points_list,2)
    current_2D(1)=(shp(finded_points_list{i}(1,4),1)-(b1*b1p))/(a1*a1p);
    current_2D(2)=(shp(finded_points_list{i}(1,4),2)-(b2*b2p))/(a2*a2p);
        plot(current_2D(1),current_2D(2),'r+');
end
% for i=1:size(finded_points_list,2)
%     current_2D(1)=(shp(finded_points_list{i}(1,4),1)-(b1))/(a1);
%     current_2D(2)=(shp(finded_points_list{i}(1,4),2)-(b2))/(a2);
%         plot(current_2D(1),current_2D(2),'r+');
% end
for i=1:size(Data_2D,1)
    plot(Data_2D(i,1),Data_2D(i,2),'g+');
end
