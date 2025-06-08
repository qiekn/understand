-- area has same empty and shape

newlevel={}

newlevel.level_str={
  {"C U",
   "  S"},
  {"C  ",
   " U ",
   "U S"},
  {"C..",
   "...",
   "U.S"},
  {"S..S",
   ".U..",
   "..U.",
   "C..."},
  {"C.U.S",
   "..U..",
   ".....",
   "..U..",
   "..U.."}
}

newlevel.correct_num=4

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isBlock("U")
  FloodFill()
  local ans=true
  for i=1,len(FloodFillRes[currentPanel])do
    local cnt=0
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str==" "then
        cnt=cnt+1
      else
        cnt=cnt-1
      end
    end
    if cnt~=0 then
      ans=false
    end
  end
  correct[currentPanel][4]=ans
end

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=3,y=2}
}
return newlevel
