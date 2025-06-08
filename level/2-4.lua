--length is four


newlevel={}


newlevel.level_str={
  {"CUUS"},
  {"C U",
   " U ",
   "U S"},
  {"CCCC",
   "UUUU",
   "SSSS"},
  {"CUS",
   "U U",
   "CUS"},
  {"C S",
   " U ",
   "S C"},
  {"UC  S",
   "     ",
   "S  CU"}
}

newlevel.correct_num=3
newlevel.hint={
  {x=1,y=1},
  {x=4,y=1},
}

newlevel.text="Recheck your conclusion before moving forward."

function newlevel.checkVictory()
  FloodFill()
  local cnt=0
  for k,v in pairs(FloodFillShapeCount[currentPanel][-1]) do
    if(k~=" ")then
      cnt=cnt+v
      print(k,v)
    end
  end
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=(cnt==4)
end
return newlevel
