function A=rule_4(x,y,depth,dim_x,dim_y,Tag)
%Tag(x,y)=Tag(x,y)+1;
    if x<dim_x %四个if实现规则
        Tag(x+1:dim_x,y)=Tag(x+1:dim_x,y)+1;
    end
    if x>1
        Tag(1:x-1,y)=Tag(1:x-1,y)+1;
    end
    if y<dim_y
        Tag(x,y+1:dim_y)=Tag(x,y+1:dim_y)+1;
    end
    if y>1
        Tag(x,1:y-1)=Tag(x,1:y-1)+1;
    end
    Tag(Tag==depth+1)=1 ;
    A=Tag;
end
