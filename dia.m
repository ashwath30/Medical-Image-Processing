imageRead=imread('Line2.jpg');
i3=im2bw(rgb2gray(imageRead));
row=584;
col=768;
neigh(1:row,1:col)=0;
resultt=neigh;
resultb=resultt;
result=neigh;
for j=2:row-1
    for k=2:col-1
        if(i3(j,k)==1)
            if( (i3(j,k-1)==1) && (i3(j,k+1)==1) && (i3(j-1,k)==1) && (i3(j+1,k)==1) && (i3(j-1,k-1)==1) && (i3(j-1,k+1)==1) && (i3(j+1,k-1)==1) && (i3(j+1,k+1)==1) )
                neigh(j,k)=1;
            end
        end
    end
end

for j=2:row-1
    for k=2:col-1
        if(neigh(j,k)==1)
            resultt(j,k)=min(resultt(j,k-1),min(resultt(j-1,k-1),min(resultt(j-1,k),resultt(j-1,k+1))))+1;
        end
        
    end
end

for j=row-1:-1:2
    for k=col-1:-1:2
        if(neigh(j,k)==1)
            resultb(j,k)=min(resultb(j,k+1),min(resultb(j+1,k-1),min(resultb(j+1,k),resultb(j+1,k+1))))+1;
        end
        
    end
end

for j=1:row
    for k=1:col
        if(resultt(j,k)>resultb(j,k))
             result(j,k)=resultb(j,k);
        else
            result(j,k)=resultt(j,k);
        end
    end
end



find(result==max(max(result)));

diameter=(max(max(result))+1)*2






