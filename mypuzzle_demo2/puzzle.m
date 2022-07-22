function puzzle()
%% 主函数
%loading()%开场动画
global Tag;%Tag是标记矩阵，定义成全局变量，方便传递参数 
global count;%计算步数，也设为全局变量
count=0;
global dim_x;
global dim_y;
global depth;%维度
global rule_k
[dim_x,dim_y,depth,rule_k]=setdim(3,3,9,1);%前两个参数选择维度，理论1到无穷，第三个参数范围1到9，最后一个参数选择规则目前只有四个规则所以是1到4
Tag=Disrupt(rule_k);%将标记矩阵的排列顺序打乱Tag_A;
set(gcf,'windowButtonDownFcn',@ButttonDownFcn);%点击鼠标时调用ButttonDownFcn函数
