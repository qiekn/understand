-- arrow is pre move

newlevel={}


newlevel.level_str={
  {"   ",
   " U ",
   "   "},
  {"   ",
   " U ",
   " U ",
   "   "},
  {"   ",
   "U U",
   "   "},
  {"   ",
   " R ",
   " R "},
  {"LU",
   "  ",
   "DR"},
  {"  L ",
   "  R ",
   " RL "}
}

newlevel.correct_num=2

newlevel.hint={
  {x=2,y=3},
  {x=2,y=1}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("ULRD")
  local ans=true
  for i=1,len(visit[currentPanel])do
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
  correct[currentPanel][2]=ans
end
return newlevel
