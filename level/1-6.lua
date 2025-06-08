-- ring is start, ring is end, square is cover, circle is block

newlevel={}

newlevel.level_str={
  {"O O"},
  {"CUS",
   "O O"},
  {"O S",
   " UU",
   "O C"},
  {"O  S",
   " SC ",
   " CU ",
   "U  O"},
  {"O U C O"}
}
newlevel.correct_num=4

function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("O")
  correct[currentPanel][2]=isEnd("O")
  correct[currentPanel][3]=isCover("S")
  correct[currentPanel][4]=isBlock("C")
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}

newlevel.text="Each rule is checked seperately."
return newlevel
