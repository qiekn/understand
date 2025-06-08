-- mirrored is cover

newlevel={}

newlevel.level_str={
  {"C ",
   "C "},
  {"C  ",
   "   ",
   "C  "},
  {"C  ",
   "   ",
   "  C"},
  {"C   ",
   " C  ",
   "C   ",
   " C  "},
  {"   C",
   " C  ",
   "  C ",
   " C  "},
  {"C   ",
   "  C ",
   "  C ",
   "  C "},
  {"..C...",
   "....CC",
   "..C...",
   ".C...C",
   "...C.C",
   ".....C"}
 }

newlevel.correct_num=2

function newlevel.checkVictory()
  local ans1=true
  local ans2=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str~=map[currentPanel][mapW[currentPanel]+1-i][j].str and map[currentPanel][i][j].str~=" " then
        if visit_grid[currentPanel][i][j] then
          ans1=false
          print(i,j)
        end
      end
      if map[currentPanel][i][j].str~=map[currentPanel][mapW[currentPanel]+1-i][j].str and map[currentPanel][i][j].str==" " then
        if not visit_grid[currentPanel][i][j] then
          ans2=false
          print(i,j)
        end
      end
    end
  end
  correct[currentPanel][1]=ans2
  correct[currentPanel][2]=ans1
end

newlevel.hint={
  {x=2,y=1},
  {x=2,y=2}
}
return newlevel
