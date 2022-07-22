 function Snakey(m,varargin)
    clc;
    % if ~exist('side', 'var'),
    %     side = 20;
    % end
    if ~exist('m', 'var'),
        m = 15;
        h_num=m;
        l_num = h_num;
    end
    side=25;%����߳�
    h_num=m;
    if nargin==0
%         msgbox('��Ϸ����ʧ��,�������һ�����в���');
%         return
        h_num=15;
        l_num=20;
    elseif nargin == 1
        l_num = h_num;
    else
        l_num = varargin{1};
    end
    if h_num<5 || l_num<5
        msgbox('��Ϸ����ʧ�ܣ���������С��5');
        return
    end
    Wide=l_num*side;
    High=h_num*side;
    score=0;
    pos_x=0;%���һ������
    pos_y=0;
    RoadBlock=zeros(l_num,h_num);
    V=[];
    F=[];
    pause_flag=0;
    direct=0;
    Plot_snake=0;
    Plot_food=0;
    fps = 5; 
    game = timer('ExecutionMode', 'FixedRate', 'Period',1/fps, 'TimerFcn', @snakeGame);%���ö�ʱ���Ĳ���
    scnsize = get(0,'MonitorPosition');%��ȡ��Ļ�ֱ���
    g=gcf;
    set(g,'Units','pixels','Position',[(scnsize(3)-Wide)/2,(scnsize(4)-High)/2,Wide,High],'NumberTitle','off','Name','̰����')
    g.ToolBar = 'none';
    g.MenuBar = 'none';
    g.Resize='off';
    ax=axes('parent',g);
    hold on  
    set(ax,'xtick',[0:side:Wide])
    line([0 Wide Wide 0 0], [0 0 High High 0]);
    axis equal;
    set(gca, 'xlim', [0 Wide]);
    set(gca, 'ylim', [0 High]);
    axis off
    ax.Units='Pixels';
    ax.Position=[0,0,Wide,High];
    set(g, 'KeyPressFcn', @key)
    iniSnake();%��ʼ��
    
    function iniSnake()
        for i = 0: l_num
            line([i*side i*side], [0 High], 'Color', [0 0 0])
        end
        for j = 0: h_num
            line([0 Wide], [j*side j*side], 'Color', [0 0 0])
        end
        
        f_x=randperm(l_num,1);%���һ��ʳ��
        f_y=randperm(h_num,1);
        while RoadBlock(f_x,f_y)~=0
           f_x=randperm(l_num,1);%���һ��ʳ��
           f_y=randperm(h_num,1); 
        end
        F=[F;f_x,f_y];
        RoadBlock(f_x,f_y)=-1;
        
        Plot_food=scatter(gca,pos(F(:, 1)), pos(F(:, 2)), 2*side*side/4,'g', 'filled'); 
        Plot_food.MarkerFaceColor = [1,0,0];
        
        pos_x=randperm(l_num,1);%���һ������
        pos_y=randperm(h_num,1);
        V=[pos_x,pos_y];
        RoadBlock(pos_x,pos_y)=1;
        
        
 
        Plot_snake=scatter(gca,pos(V(:, 1)), pos(V(:, 2)), side*side,'bs', 'filled'); 
        Plot_snake.MarkerFaceColor = [0 0.5 0.5];
        start(game); %��ʼ��Ϸ
    end
 
    function key(~,event)       
        switch event.Key            
          case 'uparrow'
              if direct~=2
                    direct =1;
              end
            
          case 'downarrow'
              if direct~=1
                  direct =2;
              end
            
          case 'leftarrow'
              if direct~=4
                  direct =3;
              end
           
          case 'rightarrow'
            if direct~=3
                  direct =4;
              end
            
          case 'space'
%               pause_flag=mod(pause_flag+1,2);
%               if(pause_flag==1)
%                 stop(game); 
%               else
%                   start(game);
%               end
                stop(game);
                ButtonName = questdlg('��Ϸ��ͣ......', 'Stop ', '���¿�ʼ', '������Ϸ', '�ر���Ϸ', '������Ϸ');
                switch ButtonName
                    case '���¿�ʼ'
                        clf;
                        Snakey(h_num,l_num);
                    case '������Ϸ'
                        start(game);
                    case '�ر���Ϸ'
                        close;
                    otherwise
                        start(game);  
                end
        end
    end
    function snakeGame(~,~)
        switch direct
            case 1
                pos_y=pos_y+1;
            case 2
                pos_y=pos_y-1;
            case 3
                pos_x=pos_x-1;
            case 4
                pos_x=pos_x+1;
        end
        if( pos_x>0 && pos_x<=l_num && pos_y>0 && pos_y<=h_num )
            if(RoadBlock(pos_x,pos_y)==0)
                V=[V;pos_x,pos_y];
                RoadBlock(pos_x,pos_y)=1;
                RoadBlock(V(1,1),V(1,2))=0;
                V(1,:)=[];
                set(Plot_snake, 'XData',pos(V(:, 1)),'YData', pos(V(:, 2)));
            elseif(RoadBlock(pos_x,pos_y)==-1)
                score=score+1;
                V=[V;pos_x,pos_y];
                RoadBlock(pos_x,pos_y)=1;
                f_x=randperm(l_num,1);%���һ��ʳ��
                f_y=randperm(h_num,1);
                while RoadBlock(f_x,f_y)~=0
                   f_x=randperm(l_num,1);%���һ��ʳ��
                   f_y=randperm(h_num,1); 
                end
                F(1,:)=[];
                F=[F;f_x,f_y];
                RoadBlock(f_x,f_y)=-1;
                
                set(Plot_snake, 'XData',pos(V(:, 1)),'YData', pos(V(:, 2)));
                set(Plot_food, 'XData',pos(F(:, 1)),'YData', pos(F(:, 2)));
            else
                if(direct~=0)
                    stop(game);
                    ButtonName = questdlg(strcat('SCORE:',num2str(score)), 'Game Over ', '���¿�ʼ',  '�ر���Ϸ', '���¿�ʼ');
                    switch ButtonName
                        case '���¿�ʼ'
                            clf;
                            Snakey(h_num,l_num);
                        case '�ر���Ϸ'
                            close;
                        otherwise
                                close;
                    end
                end
            end
        else
            stop(game);
            ButtonName = questdlg(strcat('SCORE:',num2str(score)), 'Game Over ', '���¿�ʼ',  '�ر���Ϸ', '���¿�ʼ');
            switch ButtonName
                case '���¿�ʼ'
                    clf;
                    Snakey(h_num,l_num);
                case '�ر���Ϸ'
                    close;
                otherwise
                        close;
            end
        end
    end
    function P=pos(v)
        P=v*side-side/2;
    end
end
