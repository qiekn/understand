-- empty is cover

newlevel={}

newlevel.level_str={
  {"C S"},
  {"C  ",
   "  S"},
  {"C  ",
   "   ",
   "  S"},
  {"C  S",
   "    ",
   "    ",
   "    "},
  {".....",
   ".C.S.",
   ".....",
   ".C.S.",
   "....."},
  {".C..",
   "...S",
   "S...",
   "..C."},
  {".....",
   ".C..S",
   ".....",
   "S..C.",
   "....."},
}

newlevel.correct_num=3

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isCover(" ")
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}
return newlevel
