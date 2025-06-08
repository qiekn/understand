newlevel={}

--one cover in pointed direction
newlevel.level_str={
  {"  D",
   "   ",
   "U  "},
  {"  L",
   "   ",
   "R  "},
  {"   ",
   "U D",
   "   "},
  {"     ",
   "R   L",
   "     "},
  {"     ",
   "R R  ",
   "     "},
  {"     ",
   " R L ",
   "     ",
   " L R ",
   "     "},
  {"      ",
   "  RL  ",
   "      "},
  {"     ",
   " R D ",
   "     ",
   " U L ",
   "     "}
}

newlevel.correct_num=2

newlevel.hint={
  {x=1,y=2},
  {x=3,y=2}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      local ch=map[currentPanel][i][j].str
      if ch=="U" then
        cnt=0
        for k=1,j-1 do
          if visit_grid[currentPanel][i][k]then
            cnt=cnt+1
          end
        end
        if cnt~=1 then
          ans=false
        end
      elseif ch=="D" then
        cnt=0
        for k=j+1,mapH[currentPanel] do
          if visit_grid[currentPanel][i][k]then
            cnt=cnt+1
          end
        end
        if cnt~=1 then
          ans=false
        end
      elseif ch=="L" then
        cnt=0
        for k=1,i-1 do
          if visit_grid[currentPanel][k][j]then
            cnt=cnt+1
          end
        end
        if cnt~=1 then
          ans=false
        end
      elseif ch=="R" then
        cnt=0
        for k=i+1,mapW[currentPanel] do
          if visit_grid[currentPanel][k][j]then
            cnt=cnt+1
          end
        end
        if cnt~=1 then
          ans=false
        end
      end
    end
  end
  correct[currentPanel][2]=ans
end
return newlevel
