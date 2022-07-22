function drawmap(A)
im=imread('puzzle1.png');
img=uint8(zeros(100,100,3));%预分配，且类型需要为unint8
global dim_x
global dim_y
% 对要显示的拼图进行赋值
for row=1:dim_x
    for col=1:dim_y
        img(1+(row-1)*100:100*row,1+(col-1)*100:100*col,:)=GetImg(im,A(row,col)); 
        %imshow(img)%测试语句
        %pause(0.5)
    end
end
imshow(img)%显示
end