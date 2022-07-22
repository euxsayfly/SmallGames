function A=SwitchRule(tag,k)
    switch rule_k
        case{1}
        tag=rule_1(x,y,depth,dim_x,dim_y,tag);
        case{2}
        tag=rule_2(x,y,depth,dim_x,dim_y,tag);
         case{3}
        tag=rule_3(x,y,depth,dim_x,dim_y,tag);
         case{4}
        tag=rule_4(x,y,depth,dim_x,dim_y,tag);
    end
end