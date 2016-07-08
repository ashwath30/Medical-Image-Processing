clc
clear all
close all
warning off %close all previous otpts
image='Images/R030.jpg';
i=imread(image);
i1=histeq(i); %to increase contrast
i2=im2bw(i1,0.5); %dataset in grey. changed to bw
i3= bwareaopen(i2,round(numel(i)*0.02));    %remove noise



x=0;y=0;c=0;        %to calulate centroid of the region
for j=1:584 %traverse
for k=1:768
    if(i3(j,k)==1) %white pixels =1. Find all white pixel points. Take their avg.
        x=x+k;
        y=y+j;
        c=c+1;
    end
end
end
x=round(x/c);
y=round(y/c);
yellow = uint8([255 255 0]); % [R G B]; class of yellow must match class of I %for drawing bloack line
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
figure;imshow(BW6);
title('canny Edge Detection');
output2='o2.jpg';
imwrite(BW6,output2);

%mod 2.5
out=imread('o2.jpg');
h = vision.ShapeInserter;
            h.Shape = 'Circles';
            h.Fill = true;
circles = int32([x y 80; x y 160]);
RGB = repmat(out,[1,1,2]);
J1 = step(out, RGB, circles);
imshow(J1);
