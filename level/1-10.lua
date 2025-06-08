-- topleft is start, topright is end

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

newlevel.correct_num=2

function newlevel.checkVictory()
  pos=visit[currentPanel][1]
  correct[currentPanel][1]=(pos.x==1)and(pos.y==1)
  pos=getlast(visit[currentPanel])
  correct[currentPanel][2]=(pos.y==1)and(pos.x==len(map[currentPanel]))
end
newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}

newlevel.text="You might be overthinking."
return newlevel
