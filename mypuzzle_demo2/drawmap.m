function drawmap(A)
im=imread('puzzle1.png');
img=uint8(zeros(100,100,3));%Ԥ���䣬��������ҪΪunint8
global dim_x
global dim_y
% ��Ҫ��ʾ��ƴͼ���и�ֵ
for row=1:dim_x
    for col=1:dim_y
        img(1+(row-1)*100:100*row,1+(col-1)*100:100*col,:)=GetImg(im,A(row,col)); 
        %imshow(img)%�������
        %pause(0.5)
    end
end
imshow(img)%��ʾ
end