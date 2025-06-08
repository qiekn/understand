newlevel={}

--keep move after visit an arrow

newlevel.level_str={
  {"   ",
   "R  ",
   "   "},
  {"  L",
   "   ",
   "R  "},
  {"  D",
   "   ",
   "U  "},
  {"     ",
   "     ",
   " DDD ",
   "     ",
   "     "},
  {"R D",
   "   ",
   "U L"},
  {"    ",
   " R D",
   "    ",
   "    "},
  {"     ",
   " R D ",
   "     ",
   "     "},
  {"    ",
   " L  ",
   "    ",
   "U   "},
  {"     ",
   "R   L",
   "     "}
}

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=2},
  {x=3,y=2}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("all")
  local ans=true
  local ans2=true
  GetDirection()
  GetVisitOrder()
  local last_ch=" "
  for i=1,len(visit[currentPanel])-1 do
    local ch=map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str
    if ch~=" " and direction[i]~=ch then
      ans=false
    end
    print("last",last_ch)
    if last_ch~=" " then
      if direction[i]~=last_ch then
        if last_ch=="U" then
          if visit[currentPanel][i].y~=1 then
            print(visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y-1])
            if visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y-1]==0 or visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y-1]>i then
              ans2=false
            end
          end
        end
        if last_ch=="D" then
          if visit[currentPanel][i].y~=mapH[currentPanel] then
            print(visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y+1])
            if visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y+1]==0 or visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y+1]>i then
              ans2=false
            end
          end
        end
        if last_ch=="L" then
          if visit[currentPanel][i].x~=1 then
            print(visit_order[visit[currentPanel][i].x-1][visit[currentPanel][i].y])
            if visit_order[visit[currentPanel][i].x-1][visit[currentPanel][i].y]==0 or visit_order[visit[currentPanel][i].x-1][visit[currentPanel][i].y]>i then
              ans2=false
            end
          end
        end
        if last_ch=="R" then
          if visit[currentPanel][i].x~=mapW[currentPanel] then
            print(visit_order[visit[currentPanel][i].x+1][visit[currentPanel][i].y])
            if visit_order[visit[currentPanel][i].x+1][visit[currentPanel][i].y]==0 or visit_order[visit[currentPanel][i].x+1][visit[currentPanel][i].y]>i then
              ans2=false
            end
          end
        end
        last_ch=" "
      end
    end
    if ch~=" " then
      last_ch=ch
    end
  end
  if map[currentPanel][getlast(visit[currentPanel]).x][getlast(visit[currentPanel]).y].str~=" " then
    ans=false
    last_ch=map[currentPanel][getlast(visit[currentPanel]).x][getlast(visit[currentPanel]).y].str
  end
  i=len(visit[currentPanel])
  if last_ch=="U" then
    if visit[currentPanel][i].y~=1 then
      if visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y-1]==0 or visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y-1]>i then
        ans2=false
      end
    end
  end
  if last_ch=="D" then
    if visit[currentPanel][i].y~=mapH[currentPanel] then
      print(visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y+1])
      if visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y+1]==0 or visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y+1]>i then
        ans2=false
      end
    end
  end
  if last_ch=="L" then
    if visit[currentPanel][i].x~=1 then
      print(visit_order[visit[currentPanel][i].x-1][visit[currentPanel][i].y])
      if visit_order[visit[currentPanel][i].x-1][visit[currentPanel][i].y]==0 or visit_order[visit[currentPanel][i].x-1][visit[currentPanel][i].y]>i then
        ans2=false
      end
    end
  end
  if last_ch=="R" then
    if visit[currentPanel][i].x~=mapW[currentPanel] then
      print(visit_order[visit[currentPanel][i].x+1][visit[currentPanel][i].y])
      if visit_order[visit[currentPanel][i].x+1][visit[currentPanel][i].y]==0 or visit_order[visit[currentPanel][i].x+1][visit[currentPanel][i].y]>i then
        ans2=false
      end
    end
  end
  correct[currentPanel][2]=ans
  correct[currentPanel][3]=ans2
end
return newlevel
