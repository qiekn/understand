newlevel={}

--Area Count Is Different

newlevel.level_str={
  {"C S C"},
  {"C S S C"},
  {"C S",
   "   ",
   "C S"},
  {"S  C  S",
   "       ",
   "C  S  C"},
  {"S  S  S",
   "       ",
   "C  C  C"},
  {"C S S C S S C",
   "             "},
  {"   S  S",
   " S     ",
   "   S  C",
   " C     ",
   "   C  C",
   "S      ",
   "S    SS"}
}

newlevel.correct_num=3

newlevel.text="Count the shapes."

newlevel.hint={
  {x=2,y=1}
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  local ans2=true
  local cc={}
  for i=1,len(FloodFillShapeCount[currentPanel]) do
    if FloodFillShapeCount[currentPanel][i]["C"]~=1 then
      ans=false
    end
    tmp=0
    for k,v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k~=" " then
        tmp=tmp+v
      end
    end
    if cc[tmp]~=nil then
      ans2=false
    else
      cc[tmp]=1
    end
  end
  correct[currentPanel][2]=ans
  correct[currentPanel][3]=ans2
end
return newlevel
