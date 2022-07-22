function A=Disrupt(rule_k)
global dim_x;
global dim_y;
global depth
A=ones(dim_x,dim_y);
for k=1:420
x=unidrnd(dim_x);
y=unidrnd(dim_y);
    switch rule_k
        case{1}
        A=rule_1(x,y,depth,dim_x,dim_y,A);
        case{2}
        A=rule_2(x,y,depth,dim_x,dim_y,A);
         case{3}
        A=rule_3(x,y,depth,dim_x,dim_y,A);
         case{4}
        A=rule_4(x,y,depth,dim_x,dim_y,A);
    end
end

drawmap(A);
end