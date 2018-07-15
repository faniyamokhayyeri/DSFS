function points_selection_2d
clc
close all
clear

f = figure;
events(f)
I_desired=imread('desired_image.tif');
imshow(I_desired,'Border','tight');
f.Units='pixels';
f.Pointer='cross';
hold on
xlim([0 size(I_desired,1)]);ylim([0 size(I_desired,2)])
f.Position=[120 120 size(I_desired,1)*4 size(I_desired,1)*4];


f.WindowButtonMotionFcn=@click_callback;



function click_callback(hObject,~)

mousePointCoords = ginput(1)
plot(mousePointCoords(:,1), mousePointCoords(:,2),'r+','MarkerSize',10);

% pos=get(hObject,'CurrentPoint');
% hold on
% fig_pose=f.Position;
% % plot(10,10,'r+')
% plot(pos(1)/4,(fig_pose(3)-pos(2))/4,'r+')
% disp(['You clicked X:',num2str(pos(1)),', Y:',num2str(pos(2))]);
