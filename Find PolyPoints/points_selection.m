function points_selection
clc
clear
close all
global f
[model msz] = load_model();
alpha_sample=zeros(199,1);
beta_sample=zeros(199,1);
alpha_sample(25)=20;alpha_sample(65)=5;
I_desired=model2image(model , alpha_sample , beta_sample);
fig=gcf;
dcm_obj = datacursormode(fig);
fig.MenuBar='none';
fig.Resize='off';
set(dcm_obj,'UpdateFcn',@myupdatefcn)
% Save the following code as myupdatefcn.m on the MATLAB path:
datacursormode toggle

function txt = myupdatefcn(empt,event_obj)
% Customizes text of data tips
pos = get(event_obj,'Position')
txt = '';

