-- all is cover

newlevel={}

newlevel.level_str={
  {"C S"},
  {"CS",
   "  "},
  {"C S",
   "   ",
   "S C"},
  {"C S",
   "   ",
   "C S"},
  {"    ",
   "CCSS",
   "    "},
  {"     ",
   " S C ",
   " S C ",
   " S C ",
   "     "}
}
newlevel.correct_num=3

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isCover("CS ")
end
newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}

newlevel.text="Same panel, different rules."
return newlevel
