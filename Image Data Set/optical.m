clc
clear all
close all
warning off %close all previous otpts
image='Images/R154.jpg';
i=imread(image);
i1=histeq(i); %to increase contrast
i2=im2bw(i1,0.5); %dataset in grey. changed to bw
i3= bwareaopen(i2,round(numel(i)));    %remove noise


[m n]=size(i);
x=0;y=0;c=0;        %to calulate centroid of the region
for j=1:m %traverse
for k=1:n
    if(i3(j,k)==1) %white pixels =1. Find all white pixel points. Take their avg.
        x=x+k;
        y=y+j;
        c=c+1;
    end
end
end
x=round(x/c);
y=round(y/c);
yellow = uint8([0 0 0]); % [R G B]; class of yellow must match class of I %for drawing bloack line
shapeInserter = vision.ShapeInserter('Shape','Circles','BorderColor','Custom','CustomBorderColor',yellow);
circles = int32([x y 80; x y 160; x y 400]); %radius
RGB = repmat(i,[1,1,3]); 
J = step(shapeInserter, RGB, circles);
imshow(J);
hold on
%plot(x,y,'*');
output1='o1.jpg';
imwrite(J,output1);

%mod 2


I = rgb2gray(imread(output1));
BW6 = edge(I,'canny',0.12);

title('canny Edge Detection');
output2='o2.jpg';
imwrite(BW6,output2);
figure;imshow(BW6);


%mod 3
i=imread(output2);
% BW=rgb2gray(i);
bifur = im2bw(i, 0.5);
[m n] = size(bifur);
figure;imshow(bifur);
count(1:m,1:n)=0;
transition(1:m,1:n)=0;

%-------------------------------------------------------------------

for j=2:m-1  % Not considering the first and last row
for k=2:n-1  % Not considering the first and last column
     if(bifur(j,k)==1)
         if(bifur(j-1,k-1)==1)
             count(j,k)=count(j,k)+1;            
         end
         if(bifur(j,k-1)==1)
            count(j,k)=count(j,k)+1;
         end
         if(bifur(j+1,k-1)==1)
             count(j,k)=count(j,k)+1;
         end
         if(bifur(j-1,k)==1)
            count(j,k)=count(j,k)+1;
         end
         if(bifur(j+1,k)==1)
             count(j,k)=count(j,k)+1;
         end
         if(bifur(j-1,k+1)==1)
             count(j,k)=count(j,k)+1;
         end
         if(bifur(j,k+1)==1)
            count(j,k)=count(j,k)+1;
         end
         if(bifur(j+1,k+1)==1)
            count(j,k)=count(j,k)+1;
         end
         
         if(bifur(j-1,k)==1)
                if(bifur(j-1,k-1)==0)
                    transition(j,k)=transition(j,k)+1; % count matrix = count of white pix around that point, % trans matrix = stores the count of no: of white-black transitions 
                end
         end
         if(bifur(j-1,k-1)==1)
                if(bifur(j,k-1)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end
         if(bifur(j,k-1)==1)
                if(bifur(j+1,k-1)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end
         if(bifur(j+1,k-1)==1)
                if(bifur(j+1,k)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end
         if(bifur(j+1,k)==1)
                if(bifur(j+1,k+1)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end
         if(bifur(j+1,k+1)==1)
                if(bifur(j,k+1)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end
         if(bifur(j,k+1)==1)
                if(bifur(j-1,k+1)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end
         if(bifur(j-1,k+1)==1)
                if(bifur(j-1,k)==0)
                    transition(j,k)=transition(j,k)+1;
                end
         end 
         
     end
        
end %trans >2 and white count >3, then those pts which have white are plotted 
end
                                                                                                                                                                                                                                                    
points(100,100)=0;
i=1;
%transition=average(image);
[c d]=size(transition)
 title('Bifurcation');
  hold on
  for j=1:c
  for k=1:d
        if(transition(j,k)>2 || count(j,k)>4)  
            hold on
          plot(k,j,'g.')
          points(i,1)=k;
          points(i,2)=j;
          i=i+1;
          
        end    
  end
  end
  size=i-1
 
  
  %module 4
  %{
  for i=1:size
for j=1:size
if(i==j)
adj(i,j)=0;
else
c=random('Poisson',1,1);
d=mod(c,2);
adj(i,j)=d;
adj(j,i)=d;
end
end
end

n = length(adj); % number of nodes
tr = zeros(n);   % initialize tree. n*n matrix setting to zero


tr = zeros(n);
adj(find(adj==0))=inf; % set all zeros in the matrix to inf

conn_nodes = 1;        % nodes part of the min-span-tree
rem = [1:n]; 
rem_nodes=setdiff(rem,conn_nodes);% remaining nodes

while length(rem_nodes)>0
  [minlink]=min(min(adj(conn_nodes,rem_nodes)));
  ind=find(adj(conn_nodes,rem_nodes)==minlink);

  [ind_i,ind_j] = ind2sub([length(conn_nodes),length(rem_nodes)],ind(1));

  i=conn_nodes(ind_i); j=rem_nodes(ind_j); % gets back to adj indices
  tr(i,j)=1; tr(j,i)=1;
  conn_nodes = [conn_nodes j];
  rem_nodes = setdiff(rem_nodes,j);
  
  
end
new(1:size,2)=0;
for i=1:size
    new(i,1)=points(i,1);
    new(i,2)=points(i,2);
end
gplot(tr,new,'-*')


%}