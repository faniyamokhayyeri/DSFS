format longG
clc
clear
close all
% points conversion
data_2D=load('2D_points_calib.txt')
data_3D=load('3D_points_calib.txt')
% a1*data_2D(:,1)+b1=data_3D(:,1)
% a2*data_2D(:,2)+b2=data_3D(:,3)

disp('******************************')
Coef1=[data_2D(:,1) ones(size(data_2D,1),1)]\data_3D(:,1)
a1=Coef1(1);b1=Coef1(2);


disp('******************************')
Coef2=[data_2D(:,2) ones(size(data_2D,1),1)]\data_3D(:,3)
a2=Coef2(1);b2=Coef2(2);

new_3D(:,1)=a1*data_2D(:,1)+b1;
new_3D(:,3)=a2*data_2D(:,2)+b2;

hold on
plot(data_3D(:,1),data_3D(:,3),'b+');
plot(new_3D(:,1),new_3D(:,3),'r+');

save coefs Coef1 Coef2