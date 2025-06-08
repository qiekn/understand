--area has 1 number, area is reverse, area size equals number

newlevel={}

newlevel.level_str={
  {"2 ",
   "  "},
  {"   ",
   " 4 ",
   "   "},
  {"   ",
   " 6 ",
   "   "},
  {"     ",
   "     ",
   "  3  ",
   "     ",
   "     "},
  {"     ",
   "     ",
   "  5  ",
   "     ",
   "     "},
  {"     ",
   "  3  ",
   "     ",
   "  4  ",
   "     "},
  {"3   2",
   "     ",
   "     ",
   "     ",
   "2   3"},
  {"4   2",
   "     ",
   "     ",
   "     ",
   "2   4"},
  {"     ",
   "     ",
   "  7  ",
   "     ",
   "     "}

 }

newlevel.correct_num=4

newlevel.hint={
  {x=1,y=2},
  {x=2,y=2}
}
newlevel.CircleColor={1,3,5,6}

function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  local ans2=true
  local ans3=true

  FloodFill()
  for i=1,len(FloodFillRes[currentPanel])do
    if FloodFillShapeCount[currentPanel][i]["~"]~=1 then
      ans=false
    end
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str=="~" then
        if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].num~=len(FloodFillRes[currentPanel][i]) then
          ans2=false
        end
      end
    end
    maxX,minX,maxY,minY=AreaMaxMin(FloodFillRes[currentPanel][i])
    ans3=ans3 and AreaMirror(FloodFillRes[currentPanel][i],FloodFillRes[currentPanel][i],maxX+minX,maxY+minY,"reverse")
  end

  correct[currentPanel][2]=ans
  correct[currentPanel][3]=ans2
  correct[currentPanel][4]=ans3
end
return newlevel
