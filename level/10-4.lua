-- arrow is direction and divide

newlevel={}

newlevel.level_str={
  {" R "},
  {" R ",
   " L ",
   " R "},
  {"      ",
   " R  R ",
   "      "},
  {"     ",
   "U R D",
   "  L  "},
  {"     ",
   "  L  ",
   "  L  "},
  {".........",
   ".........",
   ".........",
   "..UUUUU..",
   ".........",
   ".........",
   "........."},
 }

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}
newlevel.CircleColor={1,7,9}

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isCover("all")
  local ans=true
  local ans2=true
  for i=1,len(visit[currentPanel])do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="U" then
      if i==len(visit[currentPanel]) or visit[currentPanel][i+1].x~=visit[currentPanel][i].x or visit[currentPanel][i+1].y~=visit[currentPanel][i].y-1 then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="L" then
      if i==len(visit[currentPanel]) or visit[currentPanel][i+1].x~=visit[currentPanel][i].x-1 or visit[currentPanel][i+1].y~=visit[currentPanel][i].y then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="D" then
      if i==len(visit[currentPanel]) or visit[currentPanel][i+1].x~=visit[currentPanel][i].x or visit[currentPanel][i+1].y~=visit[currentPanel][i].y+1 then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="R" then
      if i==len(visit[currentPanel]) or visit[currentPanel][i+1].x~=visit[currentPanel][i].x+1 or visit[currentPanel][i+1].y~=visit[currentPanel][i].y then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="D" then
      if i==1 or visit[currentPanel][i-1].x~=visit[currentPanel][i].x or visit[currentPanel][i-1].y~=visit[currentPanel][i].y-1 then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="R" then
      if i==1 or visit[currentPanel][i-1].x~=visit[currentPanel][i].x-1 or visit[currentPanel][i-1].y~=visit[currentPanel][i].y then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="U" then
      if i==1 or visit[currentPanel][i-1].x~=visit[currentPanel][i].x or visit[currentPanel][i-1].y~=visit[currentPanel][i].y+1 then
        ans=false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="L" then
      if i==1 or visit[currentPanel][i-1].x~=visit[currentPanel][i].x+1 or visit[currentPanel][i-1].y~=visit[currentPanel][i].y then
        ans=false
      end
    end
  end

  GetDirection()
  for i=1,len(visit[currentPanel])do
    if i==1 or i==len(visit[currentPanel])then
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str~=" " then
        ans2=false
      end
    else
      if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str~=" " then
        j1=i-1
        while j1>0 and direction[j1]==direction[i-1]do
          j1=j1-1
        end
        j2=i
        while j2<len(visit[currentPanel]) and direction[j2]==direction[i]do
          j2=j2+1
        end
        if i-1-j1~=j2-i then
          ans2=false
        end
      end
    end
  end

  correct[currentPanel][2]=ans
  correct[currentPanel][3]=ans2
end

return newlevel
