function loading()
%开场动画
im=imread('puzzle1.png');
img=imread('title.png');%预分配，且类型需要为unint8
A=[1,2,3;4,5,6;7,8,9];
for row=1:3
    for col=1:3
        img(1+(row-1)*100:100*row,1+(col-1)*100:100*col,:)=GetImg(im,A(row,col)); 
        imshow(img)
        pause(0.3)
    end
end
imshow(img)%显示