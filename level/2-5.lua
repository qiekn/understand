--length is seven, start is end

newlevel={}


newlevel.level_str={
  {"S C C S"},
  {"S     S",
   " C   C "},
  {"C    C",
   "C    C"},
   {"UDU",
    "   ",
    "UDU"},
  {"S   S",
   "S   S"},
   {"O  O",
    "    ",
    " O  "},
  {"SCOTCS",
   "  TO  "}
}

newlevel.correct_num=2

function newlevel.checkVictory()
  local tmp=map[currentPanel][visit[currentPanel][1].x][visit[currentPanel][1].y].str
  if tmp==" " then
    tmp="?"
  end
  correct[currentPanel][1]=isEnd(tmp)
  correct[currentPanel][2]=len(visit[currentPanel])==7
end
newlevel.hint={
  {x=1,y=1},
  {x=7,y=1},
}
newlevel.text="What is in common?"
return newlevel
