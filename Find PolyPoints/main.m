% main
clc
close all
clear

[model msz] = load_model();

alpha=zeros(199,1);
beta=zeros(199,1);
shape  = coef2object( alpha, model.shapeMU, model.shapePC, model.shapeEV );
shp = reshape(shape, [ 3 prod(size(shape))/3 ])';

featre_points=load('3D_points.txt');
temp=featre_points;
clear featre_points;
featre_points=[temp(:,1) temp(:,3) temp(:,2)];
% hold on
% for j=1:10:size(shp,1)
%     plot3(shp(j,1),shp(j,2),shp(j,3),'r.')
% end
% % 
% % for j=1:size(featre_points,1)
% %     plot3(featre_points(j,1),featre_points(j,2),featre_points(j,3),'b+')
% % end

for i=1:size(featre_points,1)
    k=0;
    for j=1:size(shp,1)

        if norm(shp(j,:)-featre_points(i,:))<1
                    k=k+1;
            finded_points_list{i}(k,:)=[shp(j,:) j];
        end
    end
end

save finded_points_list finded_points_list