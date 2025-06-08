-- all is fading

newlevel={}

newlevel.level_str={
  {"C S",
   "   ",
   "S C"},
  {"C   C",
   " S S ",
   "  C  ",
   " S S ",
   "C   C"},
  {"C S C",
   "     ",
   "S   S",
   "     ",
   "C   C"},
  {"SCSS",
   "SCCS",
   "CCCS"},
  {"S SCS",
   " C   ",
   "S S S",
   "    C",
   "S S S"}
}
newlevel.correct_num=2

function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("C")
  correct[currentPanel][2]=isBlock("S")
end

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=3,y=2},
  {x=3,y=3},
}

newlevel.isFading=true

newlevel.text="You have the necessary information."
return newlevel
