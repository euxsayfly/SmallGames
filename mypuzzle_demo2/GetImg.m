function X=GetImg(img,k)
%ȡ����k��ͼ
  X=img(:,100*(k-1)+1:100*k,:);
end