function logg = quichorv5
map = input('please input the initial map ');
playor = input('please select the mode ');
if isempty(map)
   map = [1 1 1 1;1 0 0 1;2 0 0 2;2 2 2 2];
   i = randi(2,1);
if i == 1
   player = playor([1 2]);
else
    player = playor([3 4]);
end
else
    player = input('please select the first player ');
end
     
disp('an initial map of normalization');
disp(map);
index = 0;
index_ismobile = 0;
counter = 1;
while index_ismobile == 0
    mp = interface_input(map,player,index,playor);
    disp([player,' is going to move.']);
    disp(['mp = ','[',num2str(mp),']']);
    map = move(map,player,index,mp);
    [map,index] = iscontinue(map,player,mp,playor);
    disp(map);
    %===================================================
    logg(counter,:) = [str2double(player(1)),mp,index];
    counter = counter + 1;  
    %===================================================
    [map,player,index] = inquire(map,player,index,playor);
    [map,player,index] = quich(map,player,index,playor);
    [index_ismobile,winner] = isgameover(map,player,index,playor);
end
 disp(['winner is ',num2str(winner)]);

    function mp = interface_input(map,player,index,playor)
        switch index
        case 0
            mp = div_input(map,player,index,playor);   
        case 1
            counter_input = 0;
            index_attack = 0;
            while index_attack == 0
            disp([num2str(player) ' has ',num2str(4-counter_input),' chances to move!']);
            mp = div_input(map,player,index,playor);   
            index_attack = isattackeff(map,player,index,mp);
            counter_input = counter_input + 1;
            if counter_input > 3
               [map,player,index] = quich(map,player,0,playor);
               mp = div_input(map,player,index,playor); 
               break;
            end
            end
        end
        

function mp = move_input(map,player,index)
        index_mp = 0;
        while index_mp ==0;
           disp([num2str(player) ' is suppoed  to move']);
           mp = input('please select move');
             if isempty(mp)
               continue;
           end
           if all([mp>0,mp<5,abs(mp([3 4])-mp([1 2]))<2])
              if map(mp(1),mp(2)) ==str2double(player(1))
                  if map(mp(3),mp(4)) == 0
                     index_mp = 1;
                  end
              end
           end
        end
        
function mp = div_input(map,player,index,playor)
switch player
        case '1n'
            mp = move_input(map,player,index);
        case '2n'
            mp = move_input(map,player,index);
        case '1e'
            mp = easyplayer(map,player,index);
        case '2e'
            mp = easyplayer(map,player,index);
        case '1m'
            mp = midplayer(map,player,index);
        case '2m'
            mp = midplayer(map,player,index);
        case '1h'
            mp = hardplayer(map,player,index,playor);
        case '2h'
            mp = hardplayer(map,player,index,playor);
        otherwise
            error('invalide player argument');
end    
          
        
function new_map = move(map,player,index,mp)
    t =  map(mp(1),mp(2));
    map(mp(1),mp(2)) =  map(mp(3),mp(4));
    map(mp(3),mp(4)) = t;
new_map = map;
   
    function choice = choices(map,player,index)
k = 1;
for i = 1:4
    for j = 1:4
        if map(i,j) == str2double(player(1))
            computer(k,:) = [i j];
            k = k+1;
        end
    end
end

if k == 1;
    computer = [];
end

k = 1;
for i = 1:4
    for j =1:4
        if map(i,j) == 0
            emptor(k,:) = [i,j];
            k = k+1;
        end
    end
end
if k == 1;
    emptor = [];
end

[m,~] = size(computer);
[n,~] = size(emptor);

k = 1;
for i = 1:m
    for j = 1:n
        if all(abs(computer(i,:)-emptor(j,:))<2)
            choice(k,:) = [computer(i,:),emptor(j,:)];
            k = k+1;
        end
    end
end

if k == 1;
    choice = [];
end

 function index_attack = isattackeff(map,player,index,mp)
    index_attack = 0;
    map = move(map,player,index,mp);
     DP = mp([3,4]);
    judge_matrix_11 = [2 1 1 0;0 2 1 1;1 1 2 0;0 1 1 2];
    judge_matrix_21 = [1 2 2 0;0 1 2 2;2 2 1 0;0 2 2 1];     
    judge_matrix_12 = [2 1 2 0;0 2 1 2];
    judge_matrix_22 = [1 2 1 0;0 1 2 1];
   
    
   switch str2double(player(1))
       case 1
           %style 1 of row check 
           for i = 1:4
               if all(map(DP(1),:) == judge_matrix_11(i,:))  
                  index_attack = 1;
               end
           end
           
           %style 2 of row check
           for i = 1:2
               if all(map(DP(1),:) == judge_matrix_12(i,:))
                 index_attack = 1;
               end   
           end
           
           
           
           %style 1 of column check
           for i = 1:4
               t = map(:,DP(2))';
               if all(t == judge_matrix_11(i,:))
                  index_attack = 1;
               end
           end
           
            %style 2 of column check
            for i = 1:2
                t = map(:,DP(2))';
                if all( t == judge_matrix_12(i,:) )
                   index_attack = 1;
               end   
            end
           
       case 2
            %style 1 of row check 
           for i = 1:4
               if all(map(DP(1),:) == judge_matrix_21(i,:))
                  index_attack = 1;
               end
           end
           
           %style 2 of row check
           for i = 1:2
               if all(map(DP(1),:) == judge_matrix_22(i,:))
                  index_attack = 1;
               end   
           end
    

           %style 1 of column check
           for i = 1:4
               t = map(:,DP(2))';
               if all(t == judge_matrix_21(i,:))
                  index_attack = 1;
               end
           end
           
            %style 2 of column check
            for i = 1:2
                t = map(:,DP(2))';
                if all( t == judge_matrix_22(i,:) )
                   index_attack = 1;
               end   
            end
            
     
   end

function [map,player,index] = inquire(map,player,index,playor)
    if index == 1
      switch player
          case playor([1 2])
              switch player(2)
                  case 'n'
                     str = input([num2str(player) ' has a chance to step forward! '...
                         ,'is ',num2str(player),' going to continue?']);
                     switch str
                         case 'y'
                             index = 1;
                         case 'n'
                             index = 0;
                     end
                  otherwise
                      index = 1;
              end
          case playor([3 4])
               switch player(2)
                  case 'n'
                    str = input([num2str(player) ' has a chance to step forward! '...
                         ,'is ',num2str(player),' going to continue?']);
                     switch str
                         case 'y'
                             index = 1;
                         case 'n'
                             index = 0;
                     end
                  otherwise
                      index = 1;
              end
      end
    end
       
    
function mp = easyplayer(map,player,index)
choice = choices(map,player,index);
[length_choice,~] = size(choice);
m = randi(length_choice,1);
    mp = choice(m,:);
   
  function mp = midplayer(map,player,index)
 
choice = choices(map,player,index);

[length_choice,~] = size(choice);
    
r = 1:length_choice;
while ~isempty(r)
    n = length(r);
    m = randi(n,1);
    mp = choice(r(m),:);
    index_isattack = isattackeff(map,player,index,mp);
    if index_isattack == 1
        break;
    end
    
    if isempty(r)
    m = randi(length_choice,1);
    mp = choice(m,:);
    end
    r = setdiff(r,r(m));
end

function mp = hardplayer(map,player,index,playor)
choice = choices(map,player,index);

[length_choice,~] = size(choice);
    
r = 1:length_choice;
while ~isempty(r)
    n = length(r);
    m = randi(n,1);
    mp = choice(r(m),:);
    index_isattack = isattackeff(map,player,index,mp);
    if index_isattack == 1
        break;
    end
    
    r = setdiff(r,r(m));
    
         if isempty(r)
            rp = 1:length_choice;
            while ~isempty(rp)
    
            n = length(rp);
            m = randi(n,1);
            mp = choice(rp(m),:);
            new_map = move(map,player,index,mp);
            playerr = player;
    
            if playerr ==playor([1 2])
               playerr = playor(3);
            else
               playerr = playor([1 2]);
            end
       
            index_isattack = isattack(new_map,playerr,index);
            if index_isattack == 0
               break;
            end
            
            if isempty(rp)
               m = randi(length_choice,1);
               mp = choice(m,:);
            end
            
            rp = setdiff(rp,rp(m));
            end
         end
        
end

function index_isattack = isattack(map,player,index)
        index_isattack = 0;
        choice = choices(map,player,index);
        [length_choice,~] = size(choice);
        for i = 1:length_choice
            index_isattackeff = isattackeff(map,player,index,choice(i,:));
            if index_isattackeff == 1
                index_isattack = 1;
                break;
            end
        end
      
 function [new_map,index] = iscontinue(map,player,mp,playor)
    DP = mp([3,4]);
    judge_matrix_11 = [2 1 1 0;0 2 1 1;1 1 2 0;0 1 1 2];
    judge_matrix_21 = [1 2 2 0;0 1 2 2;2 2 1 0;0 2 2 1];     
    judge_matrix_12 = [2 1 2 0;0 2 1 2];
    judge_matrix_22 = [1 2 1 0;0 1 2 1];
   index = 0;
    
   switch str2double(player(1))
       case 1
           %style 1 of row check 
           for i = 1:4
               if all(map(DP(1),:) == judge_matrix_11(i,:))
                  map(DP(1),i) = 0;    
                  index = 1;
               end
           end
           
           %style 2 of row check
           for i = 1:2
               if all(map(DP(1),:) == judge_matrix_12(i,:))
                  map(DP(1),i) = 0;
                  map(DP(1),i+2) = 0;
                  index = 1;
               end   
           end
            
           %style 1 of column check
           for i = 1:4
               t = map(:,DP(2))';
               if all(t == judge_matrix_11(i,:))
                  map(i,DP(2)) = 0;
                  index = 1;
               end
           end
           
            %style 2 of column check
            for i = 1:2
                t = map(:,DP(2))';
                if all( t == judge_matrix_12(i,:) )
                   map(:,DP(2)) = [0 0 0 0]';
                   index = 1;
               end   
            end
                 
       case 2
            %style 1 of row check 
           for i = 1:4
               if all(map(DP(1),:) == judge_matrix_21(i,:))
                  map(DP(1),i) = 0;
                  index = 1;
               end
           end
           
           %style 2 of row check
           for i = 1:2
               if all(map(DP(1),:) == judge_matrix_22(i,:))
                  map(DP(1),i) = 0;
                  map(DP(1),i+2) = 0;
                  index = 1;
               end   
           end
           
           %style 1 of column check
           for i = 1:4
               t = map(:,DP(2))';
               if all(t == judge_matrix_21(i,:))
                  map(i,DP(2)) = 0;
                  index = 1;
               end
           end
           
            %style 2 of column check
            for i = 1:2
                t = map(:,DP(2))';
                if all( t == judge_matrix_22(i,:) )
                   map(i,DP(2)) = 0;
                   map(i+2,DP(2)) = 0;
                   index = 1;
               end   
            end
           
       otherwise
           error('mp is invalid input argument ');
   end
   
   new_map = map;
   
   
if index == 1
          index_isattack = isattack(map,player,index);
           if index_isattack == 1
              index = 1;
           else 
              index = 0;
           end
end

function [new_map,new_player,new_index] = quich(map,player,index,playor)
   new_map = map;
   new_index = index;
   if index == 0
      if player ==playor([1 2])
         new_player = playor([3 4]);
      else
         new_player = playor([1 2]);
      end
   else
       new_index = 1;
       new_player = player;
   end
                   
            function [index_ismobile,winner] = isgameover(map,player,index,playor)
                choice = choices(map,player,index);
                if isempty(choice)
                    index_ismobile = 1;
                    switch player
                        case playor([1 2])
                            winner = playor([3 4]);
                        case playor([3 4])
                            winner = playor([1 2]);
                    end
                        
                else 
                    index_ismobile = 0;
                    winner = '0';
                end
                