
clc
clear
close all
[model msz] = load_model();
alpha_sample=zeros(199,1);
beta_sample=zeros(199,1);
alpha_sample(25)=20;alpha_sample(65)=5;
I_desired=model2image(model , alpha_sample , beta_sample);
imwrite(I_desired,'desired_image.tif')

