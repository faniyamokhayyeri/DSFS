function check
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
alpha_sample=zeros(199,1);
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
load coefs
a1=Coef1(1);b1=Coef1(2);
a2=Coef2(1);b2=Coef2(2);
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
Data_3D=load('3D_points.txt')
new_2D(:,1)=(Data_3D(:,1)-b1)/a1
new_2D(:,2)=(Data_3D(:,3)-b2)/a2

figure(f_3D)
hold on
for i=1:size(new_2D,1)
    plot(new_2D(i,1),new_2D(i,2),'r+');
    text(new_2D(i,1),new_2D(i,2)-4, num2str(i),'Color','b')
end
for i=1:size(new_2D,1)
    plot(Data_2D(i,1),Data_2D(i,2),'g+');
end
