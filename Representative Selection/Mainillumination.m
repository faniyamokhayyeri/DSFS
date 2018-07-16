clc
clear all
close all

% N=100; x=rand(N,2); % Create N, 2-D data points
K=8;
load illumination15;
x=data3;
% x(:,1)=x(:,1)*500;  %15-740     25-12197
N=size(x,1);
M=N*N-N; s=zeros(M,3); % Make ALL N^2-N similarities

j=1;
for i=1:N
  for k=[1:i-1,i+1:N]
    s(j,1)=i; s(j,2)=k; s(j,3)=-sum((x(i,:)-x(k,:)).^2);
    j=j+1;
  end;
end;

p=median(s(:,3))*K; % Set preference to median similarity
[idx,netsim,dpsim,expref]=apcluster(s,p,'plot');
fprintf('Number of clusters: %d\n',length(unique(idx)));
fprintf('Fitness (net similarity): %f\n',netsim);
figure; % Make a figures showing the data and the clusters

for i=unique(idx)'
    ii=find(idx==i);
    h=plot(x(ii,1),x(ii,2),'o');
    hold on;
    col=rand(1,3);       set(h,'Color',col,'MarkerFaceColor',col);
    xi1=x(i,1)*ones(size(ii));        xi2=x(i,2)*ones(size(ii)); 
    line([x(ii,1),xi1]',[x(ii,2),xi2]','Color',col);

    % ax = gca;
    % set(gca,'Linewidth',1);
    % ax.XTick = [117.2 117.4 117.6 117.8 118 118.2 118.4 118.6]; 
    % ax.XTickLabel = {0,0.1, 0.2 0.3,0.4,0.5,0.6,0.7,0.8, 0.9, 1}; %15  8
    % ax.XTickLabel = {0.26,0.31,0.36,0.41,0.46,0.51}; %25  8
    % ax.XTickLabel = {0.23,0.28,0.33,0.38}; %35    10
    % ax.XTickLabel = {0.18,0.23,0.28,0.33,0.38,0.43,0.48, 0.53}; %65  11
end;


xlabel('Contrast')
ylabel('Illumination')


% for i = 1:nk;
% [Min,Index_min(i)]=min( (C(i,1)-data2(:,1)).^2 + (C(i,2)-data2(:,2)).^2 );
% FileName=Files(Index_min(i)).name;
% I_final = imread([path FileName]);
% %figure(i); imshow (I_final)
% %imwrite(I_final, ['Results of illumination/SelectedNontargets/' num2str(i) '.tif'] )
% %imwrite(I_final, ['Results of illumination/SelectedNontargets/NT' num2str(i) '.tif'] )
% end
