close all
% rand1 = randint(size,size,255);
% rand2 = randint(size,size,255);
% rand3 = randint(size,size,255);
% 
% colour(size,size,3)=0;
% 
% for i=1:size
%     for j=1:size
%         if(i==j)
%            ;
%         else
%             
%     colour(i,j,1)=rand1(i);
%     colour(i,j,2)=rand2(i);
%     colour(i,j,3)=rand3(i);
%     colour(j,i,1)=rand1(i);
%     colour(j,i,2)=rand2(i);
%     colour(j,i,3)=rand3(i);
%         end
%         
%     end
% end


for i=1:size
for j=1:size
if(i==j)
adj(i,j)=0;
else
    if(i<j)
       ;
    else
       adj(i,j)= isConnected(i1,points(i),points(j));
       
    end
end
end
end
new(1:size,2)=0;
for i=1:size
    new(i,1)=points(i,1);
    new(i,2)=points(i,2);
end
n = length(adj); % number of nodes

for ms=1:size
tr = zeros(n);   % initialize tree. n*n matrix setting to zero

adj(find(adj==0))=inf; % set all zeros in the matrix to inf

conn_nodes = ms ;      % nodes part of the min-span-tree
 rem = [1:n];
 rem_nodes=setdiff(rem,conn_nodes);% remaining nodes

%rem_nodes= [2:n];

while length(rem_nodes)>0
  [minlink]=min(min(adj(conn_nodes,rem_nodes)));
  ind=find(adj(conn_nodes,rem_nodes)==minlink);

  [ind_i,ind_j] = ind2sub([length(conn_nodes),length(rem_nodes)],ind(1));

  i=conn_nodes(ind_i); j=rem_nodes(ind_j); % gets back to adj indices
  tr(i,j)=1; tr(j,i)=1;
  conn_nodes = [conn_nodes j];
  rem_nodes = setdiff(rem_nodes,j);
  
  
end
figure;gplot(tr,new,'-*');

i=ms;
title(i);
hold off
end