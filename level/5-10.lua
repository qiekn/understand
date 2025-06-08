-- number equals distance to nearest cover

newlevel={}


newlevel.level_str={
  {"   ",
   " 1 ",
   "   "},
  {" 1 ",
   "   ",
   " 1 "},
  {"     ",
   "     ",
   "  2  ",
   "     ",
   "     "},
  {"     ",
   "     ",
   " 2 1 ",
   "     ",
   "     "},
  {"     ",
   "   2 ",
   " 3   ",
   "     ",
   "     "},
  {"  2  ",
   "2    ",
   "     ",
   "    2",
   "  2  "},
   {"     ",
    "     ",
    "  2  ",
    "     ",
    "    3",
    "     ",
    " 3   "},
}

newlevel.correct_num=2

newlevel.hint={
  {x=3,y=1},
  {x=3,y=3}
}
function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="~" then
        local k=i+1
        local min=1000
        while k<=mapW[currentPanel]and not visit_grid[currentPanel][k][j] do
          k=k+1
        end
        if k<=mapW[currentPanel] then
          min=math.min(k-i,min)
        end
        local k=i-1
        while k>=1 and not visit_grid[currentPanel][k][j] do
          k=k-1
        end
        if k>=1 then
          min=math.min(i-k,min)
        end
        local k=j+1
        while k<=mapH[currentPanel]and not visit_grid[currentPanel][i][k] do
          k=k+1
        end
        if k<=mapH[currentPanel]then
          min=math.min(k-j,min)
        end
        local k=j-1
        while k>=1 and not visit_grid[currentPanel][i][k] do
          k=k-1
        end
        if k>=1 then
          min=math.min(j-k,min)
        end
        if min~=map[currentPanel][i][j].num then
          ans=false
        end
      end
    end
  end
  correct[currentPanel][2]=ans
end
return newlevel
