-- area doesn't have 2*2

newlevel={}


newlevel.level_str={
  {"S C",
   "   "},
  {"S  C",
   "    "},
  {"S   C",
   "     "},
  {"S  C",
   "    ",
   "    ",
   "U  T"},
  {"S   S",
   "     ",
   "     ",
   "C   C"},
  {"S  ",
   " S ",
   "   "},
  {"........",
   "........",
   "..S..S..",
   "........",
   "........"},
  {"........",
   "........",
   "..S..S..",
   "........",
   "........",
   "..S..S..",
   "........",
   "........"},
  {"SS  C",
   "S    ",
   "  C  ",
   "     ",
   "C   C"},
  {"S......S",
   "........",
   "..C.....",
   "........",
   "........",
   ".....C..",
   ".S......",
   ".......S"}
}

newlevel.correct_num=4

newlevel.hint={
  {x=2,y=1},
  {x=2,y=2}
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  local ans3=true
  local ans4=true
  local tot=-1
  for i=1,len(FloodFillRes[currentPanel])do
    for j=1,len(FloodFillRes[currentPanel][i])do
      local tt=0
      for k=1,len(FloodFillRes[currentPanel][i])do
        if (FloodFillRes[currentPanel][i][j].x-FloodFillRes[currentPanel][i][k].x)<=1 and (FloodFillRes[currentPanel][i][j].x-FloodFillRes[currentPanel][i][k].x)>=0
        and (FloodFillRes[currentPanel][i][j].y-FloodFillRes[currentPanel][i][k].y)<=1 and (FloodFillRes[currentPanel][i][j].y-FloodFillRes[currentPanel][i][k].y)>=0 then
          tt=tt+1
        end
      end
      if tt==4 then
        ans=false
      end
    end
    local cnt=0
    local cc=" "
    for k,v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k~=" " then
        cnt=cnt+1
        cc=k
      end
    end
    if(cnt~=1)then
      ans3=false
    else
      for k=1,len(FloodFillRes[currentPanel])do
        if i~=k then
          for k2,v2 in pairs(FloodFillShapeCount[currentPanel][k]) do
            if cc==k2 then
              ans4=false
            end
          end
        end
      end
    end
  end
  correct[currentPanel][2]=ans3
  correct[currentPanel][3]=ans4
  correct[currentPanel][4]=ans
end
return newlevel
