function ButttonDownFcn(src,event)
pt = get(gca,'CurrentPoint');
y = uint8(ceil(pt(1,1)/100));
x = uint8(ceil(pt(1,2)/100));
global Tag
global count
global dim_x
global dim_y
global depth
global rule_k
if x>=1&&x<=dim_x&&y>=1&&y<=dim_y%���λ�������ִ��
    count=count+1;%���㲽��
    switch rule_k
        case{1}
        Tag=rule_1(x,y,depth,dim_x,dim_y,Tag);
        case{2}
        Tag=rule_2(x,y,depth,dim_x,dim_y,Tag);
         case{3}
        Tag=rule_3(x,y,depth,dim_x,dim_y,Tag);
         case{4}
        Tag=rule_4(x,y,depth,dim_x,dim_y,Tag);
    end

end
drawmap(Tag);

%ʤ������
for k=1:depth
    if Tag==uint8(k*ones(dim_x,dim_y))
        msgbox(strcat(num2str(count),' !You win!')); %��ʾ�����Ϣ
        pause(3);%�ӳ�
        close all %��Ϸ�������ر�����ͼ�񴰿�

    end
end
end