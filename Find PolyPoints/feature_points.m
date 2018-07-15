function feature_points
clc
close all
global f_2D 
fileID = fopen('2D_points.txt','w');
fclose(fileID);
fileID = fopen('3D_points.txt','w');
fclose(fileID);
[model msz] = load_model();
alpha_sample=zeros(199,1);
beta_sample=zeros(199,1);
alpha_sample(25)=20;alpha_sample(65)=5;
I_desired=model2image(model , alpha_sample , beta_sample);
imwrite(I_desired,'desired_image.tif')

%**************************************************************************
clc
close all
f_2D = figure;
I_desired=imread('desired_image.tif');
imshow(I_desired,'Border','tight');
f_2D.Units='pixels';
f_2D.Pointer='cross';
f_2D.MenuBar='none';
% f_2D.WindowStyle='modal';
f_2D.Resize='off';
hold on
xlim([0 size(I_desired,1)]);ylim([0 size(I_desired,2)])
f_2D.Position=[100 100 600 600];
f_2D.WindowButtonMotionFcn=@click_callback_2D;

%**************************************************************************
%**************************************************************************
%**************************************************************************
function click_callback_2D(hObject,~)
global f_2D
c = get(f_2D,'CurrentCharacter');
if ~strcmp(c,'q')
    mousePointCoords = ginput(1)
    plot(mousePointCoords(:,1), mousePointCoords(:,2),'r+','MarkerSize',10);
    fileID = fopen('2D_points.txt','a');
    fprintf(fileID,'%12.8f %12.8f\n',mousePointCoords);
    fclose(fileID);
end
c = get(f_2D,'CurrentCharacter');
if strcmp(c,'q')
     f_2D.WindowButtonMotionFcn='';
     % %**************************************************************************
f_3D=figure;
[model msz] = load_model();
alpha_sample=zeros(199,1);
beta_sample=zeros(199,1);
I_desired=model2image(model , alpha_sample , beta_sample);
f_3D.MenuBar='none';
f_3D.Resize='off';
f_3D.Position=[720 100 600 600];
% % %**************************************************************************
dcm_obj = datacursormode(f_3D);
datacursormode on
     set(dcm_obj,'UpdateFcn',@myupdatefcn)
end
% %**************************************************************************
function txt = myupdatefcn(empt,event_obj)
pos = get(event_obj,'Position')
txt = '';
fileID = fopen('3D_points.txt','a');
fprintf(fileID,'%12.8f %12.8f %12.8f\n',pos);
fclose(fileID);
