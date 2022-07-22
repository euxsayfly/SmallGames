function X=GetImg(img,k)
%取出第k张图
  X=img(:,100*(k-1)+1:100*k,:);
end