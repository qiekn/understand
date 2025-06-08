newlevel={}
--Area Size Is Three

newlevel.level_str={
 {"CCC",
  "SSS"},
 {"C C",
  " S "},
 {"C   ",
  "S  C"},
 {"C S",
  "   "},
 {"  C  ",
  "S C S"},
 {"S  ",
  " C ",
  "S  "},
 {"S    ",
  "     ",
  "     ",
  "     ",
  "S   S"},
  {" S     ",
   "   S C ",
   " C     ",
   "S     S"}
}

newlevel.correct_num=3

newlevel.text="3 is included in rule 3."

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}
function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isCover("C")
  correct[currentPanel][2]=isBlock("S")
  local ans=true
  for i=1,len(FloodFillRes[currentPanel]) do
    if len(FloodFillRes[currentPanel][i])~=3 then
      ans=false
    end
  end
  correct[currentPanel][3]=ans
end
return newlevel
