function puzzle()
%% ������
%loading()%��������
global Tag;%Tag�Ǳ�Ǿ��󣬶����ȫ�ֱ��������㴫�ݲ��� 
global count;%���㲽����Ҳ��Ϊȫ�ֱ���
count=0;
global dim_x;
global dim_y;
global depth;%ά��
global rule_k
[dim_x,dim_y,depth,rule_k]=setdim(3,3,9,1);%ǰ��������ѡ��ά�ȣ�����1�����������������Χ1��9�����һ������ѡ�����Ŀǰֻ���ĸ�����������1��4
Tag=Disrupt(rule_k);%����Ǿ��������˳�����Tag_A;
set(gcf,'windowButtonDownFcn',@ButttonDownFcn);%������ʱ����ButttonDownFcn����
