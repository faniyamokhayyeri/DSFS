clc
clear all
close all

K=10;
load pose;
x=p;
%x(:,1)=x(:,1)*500;
N=size(x,1);
M=N*N-N; s=zeros(M,3); % Make ALL N^2-N similarities
j=1;

for i=1:N
  for k=[1:i-1,i+1:N]
    s(j,1)=i; s(j,2)=k; s(j,3)=-sum((x(i,:)-x(k,:)).^2);
    j=j+1;
  end;
end;
p1=median(s(:,3))*K; % Set preference to median similarity
[idx,netsim,dpsim,expref]=apcluster(s,p1,'plot');
fprintf('Number of clusters: %d\n',length(unique(idx)));
fprintf('Fitness (net similarity): %f\n',netsim);
figure; % Make a figures showing the data and the clusters
for i=unique(idx)'
    hold on
  ii=find(idx==i); h=plot3(x(ii,1),x(ii,2),x(ii,3),'o'); hold on;
  col=rand(1,3); set(h,'Color',col,'MarkerFaceColor',col);
  xi1=x(i,1)*ones(size(ii)); xi2=x(i,2)*ones(size(ii)); xi3=x(i,3)*ones(size(ii)); 
 plot3([x(ii,1),xi1]',[x(ii,2),xi2]',[x(ii,3),xi3]','Color',col);
end;
axis equal tight;
xlabel('Pitch')
ylabel('Roll')
zlabel('Yaw')
