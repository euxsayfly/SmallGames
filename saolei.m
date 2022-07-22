
function XPBOMBS2
clear 

row=15;col=20;mines=45;
total=mines;times=1;
remine=row*col;
flags=0;
hf=figure('NumberTitle','off','Name','扫雷','menubar','none','position',[370,130,600,500]);
uh1=uimenu('label','帮助');
uimenu(uh1,'label','游戏规则','callback',['msgbox(''扫雷的规则你猜是啥呢？'')'])
colormap([1 0 0;0 0 0;.65 .65 .65;1 1 1]);
axis off
   hold on;
% C=uicontrol(gcf,'style','text','unit','normalized',...
%     '6  position',[0.45,0.86,0.09,0.078],'fontsize',17,...
%     'BackgroundColor',0.85*[1 1 1],...
%     'string','o');
C=uicontrol(gcf,'style','text','unit','normalized',...
    'position',[0.45,0.86,0.1,0.078],'fontsize',12,...
    'BackgroundColor',0.85*[1 1 1],...
    'string',['时间：' '0']);
H=uicontrol(gcf,'style','text','unit','normalized',...
    'position',[0.58,0.86,0.3,0.078],'fontsize',12,...
    'BackgroundColor',0.85*[1 1 1],... 
   'string',['total:' num2str(total)]);
F=uicontrol(gcf,'style','text','unit','normalized',...
    'position',[0.1,0.86,0.3,0.078],'fontsize',12,...
    'BackgroundColor',0.85*[1 1 1],...
   'string',['flag:' num2str(flags)]);
for m=1:row 
    for n=1:col
        h(m,n)=uicontrol(gcf,'style','push',...
            'foregroundColor',0.7*[1 1 1],...
            'BackgroundColor',0.7*[1 1 1],...
            'fontsize',15,'fontname','time new roman',...
            'Unit','normalized','position',[0.013+0.045*n,0.86-0.054*m,0.043,0.052],...
            'Visible','on',...
            'callback',@pushcallback,'ButtonDownFcn',@buttoncallback);  
    end
end
    function first_time(place)
        mine=rand(row,col);
        A=ones(row,col);
        [x,y]=find(A==1);
        postions=[x,y];
        places=[place;place+[1,0];place+[-1,0];place+[1,1];place+[0,1];
            place+[-1,1];place+[1,-1];place+[0,-1];place+[-1,-1]];
        places=intersect(postions,places,'rows');
        pos=places(:,1)+(places(:,2)-1).*row;
        mine(pos)=1;
        [~,index]=sort(mine(:));
        mine=(mine<=mine(index(mines)));
        Y=zeros(row+2,col+2);
        x=2:row+1;y=2:col+1;
        Y(x,y)=mine;
        Y(x,y)=Y(x-1,y-1)+Y(x-1,y)+Y(x-1,y+1)+Y(x,y-1)+Y(x,y+1)+Y(x+1,y-1)+Y(x+1,y)+Y(x+1,y+1);
        around=Y(x,y);
    end
function pushcallback(hobject,~)
            a = get(hobject,'position');
            hang=double((a(2)-0.86)/(-0.054))-0.0001;
            lie=double((a(1)-0.013)/0.045)-0.0001;
            place=ceil([hang,lie]);
            if times==1
                first_time(place)
                times=0;
            end
            if mine(place(1),place(2))==1&&~strcmp(get(hobject,'string'),'!')
                [p,q]=find(mine==1);
                bombs=p+row*(q-1);
                set(h(bombs),'style','text','string','x','ForegroundColor','k','backgroundcolor',0.85*[1,1,1]);
                set(hobject,'style','text','string','X','ForegroundColor',[0.8 0 0],'backgroundcolor',0.85*[1,1,1]);
                buttonName2=questdlg('你没了','Game over','close','restart','close');
                if isempty(buttonName2)
                    buttonName2='end';
                end
                if strcmp(buttonName2,'restart')
                        clf;close;
                        XPBOMBS2();
                else if strcmp(buttonName2,'close')
                            close;
                    end
                end
            end
            if (mine(place(1),place(2))==0)&&(around(place(1),place(2))~=0)&&~strcmp(get(hobject,'string'),'!')
                drawnum(hobject,place)
            end
            if (mine(place(1),place(2))==0)&&(around(place(1),place(2))==0)&&~strcmp(get(hobject,'string'),'!')
                begins=place;
                [whitea,whiteb]=find(around==0);
                white=[whitea,whiteb];
                next=[begins;begins+[1,0];begins+[-1,0];begins+[0,1];begins+[0,-1]];
                while ~isempty(intersect(white,next,'rows'))
                    [a,b,~]=intersect(white,next,'rows');
                    begins=[a;begins];white(b,:)=[];
                    ad=length(sum(begins,2));
                    next=[begins;begins+ones(ad,1)*[1,0];begins+ones(ad,1)*[-1,0];begins+ones(ad,1)*[0,1];begins+ones(ad,1)*[0,-1]];
                end
                drawbegins=begins(:,1)+row*(begins(:,2)-ones(ad,1));
                set(h(drawbegins),'style','text','string','','backgroundcolor',0.85*[1,1,1]);
                control(drawbegins)=0;
                colors=[begins;begins+ones(ad,1)*[1,0];begins+ones(ad,1)*[-1,0];begins+ones(ad,1)*[0,1];begins+ones(ad,1)*[0,-1];
                    begins+ones(ad,1)*[1,1];begins+ones(ad,1)*[1,-1];begins+ones(ad,1)*[-1,1];begins+ones(ad,1)*[-1,-1]];
                colors=unique(colors,'rows');
                [txa,txb]=find(around~=0);
                tx=[txa,txb];
                txcolors=intersect(tx,colors,'rows');
                for i=1:length(sum(txcolors,2))
                    drawnum(h(txcolors(i,1),txcolors(i,2)),txcolors(i,1:2))
                end
            end
    end
 function buttoncallback(hobject,~)
        if strcmp(get(gcf,'SelectionType'),'alt')
            if ~strcmp(get(hobject,'style'),'text')
                if ~strcmp(get(hobject,'string'),'!')
                    set(hobject,'string','!','ForegroundColor',[0.9,0,0])
                    flags=flags+1;set(F,'string',['flag:' num2str(flags)]);
                else 
                    set(hobject,'string',' ')
                    flags=flags-1;set(F,'string',['flag:' num2str(flags)])
                end
            end
        end
    end
    function drawnum(hobject,place)
        if around(place(1),place(2))==1,set(hobject,'style','text','string',1,'ForegroundColor','b','backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==2,set(hobject,'style','text','string',2,'ForegroundColor',[0,0.7,0],'backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==3,set(hobject,'style','text','string',3,'ForegroundColor',[0.8,0,0],'backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==4,set(hobject,'style','text','string',4,'ForegroundColor',[0,0,0.6],'backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==5,set(hobject,'style','text','string',5,'ForegroundColor',[0.5,0,0],'backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==6,set(hobject,'style','text','string',6,'ForegroundColor',[0,0.6,0],'backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==7,set(hobject,'style','text','string',7,'ForegroundColor',[0.75,0,0],'backgroundcolor',0.85*[1,1,1]);end
        if around(place(1),place(2))==8,set(hobject,'style','text','string',8,'ForegroundColor',[0.4,0,0],'backgroundcolor',0.85*[1,1,1]);end
        control(place(1),place(2))=0;
        if control==mine
            [p,q]=find(mine==1);
                bombs=p+row*(q-1);
                set(h(bombs),'string','!','ForegroundColor',[0.9,0,0]);
            buttonName1=questdlg('牛批呀，老铁','Congratulations','close','restart','close');
                if isempty(buttonName1)
                    buttonName1='end';
                end
                if strcmp(buttonName1,'restart')
                        clf;close;
                        XPBOMBS2();
                else if strcmp(buttonName1,'close')
                            close;
                    end
                end
        end
    end
mine=zeros(row,col);
control=ones(row,col);
around=zeros(row,col);
end
