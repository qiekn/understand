--three is start, two is end, length is four

newlevel={}


newlevel.level_str={
  {"CCC",
   "S S"},
  {"TTT",
   "C  ",
   "SS "},
  {"C S",
   "TTT",
   "C S"},
  {"LURD",
   "URD ",
   "RD  ",
   "D   "},
  {"CTCS",
   " TUT",
   "OSCO",
   "TCSC"}
}

newlevel.correct_num=3

function newlevel.checkVictory()
  CountShape()
  local a=map[currentPanel][visit[currentPanel][1].x][visit[currentPanel][1].y].str
  local b=map[currentPanel][visit[currentPanel][len(visit[currentPanel])].x][visit[currentPanel][len(visit[currentPanel])].y].str
  local cnt=0
  print(a,b)
  if(a==" ")then
    correct[currentPanel][1]=false
  else
    correct[currentPanel][1]=(shape_cnt[a]==3)
  end
  if(b==" ")then
    correct[currentPanel][2]=false
  else
    correct[currentPanel][2]=(shape_cnt[b]==2)
  end
  correct[currentPanel][3]=len(visit[currentPanel])==4
end

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=3,y=2}
}

newlevel.text="All rules are related to number."
return newlevel
