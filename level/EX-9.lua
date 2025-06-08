-- showcase

newlevel={}

newlevel.level_str={
  {"..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   ".........."},
  {"..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   "..........",
   ".........."},
  {"....",
   "....",
   "...."},
  {"......",
   "......",
   "......",
   "......",
   "......"},
  {"......",
   "......",
   "......",
   "......"},
  {"..........",
   "..........",
   "..........",
   "..........",
   "..........",
   ".........."},
  {"..........",
   "..........",
   "..........",
   "..........",
   "..........",
   ".........."}
}
newlevel.correct_num=1

display=0

function newlevel.checkVictory()
  local time={}
  print(os.date("%Y"))
  time[1]=(os.date("%Y")-os.date("%y"))/100
  time[2]=os.date("%y")
  time[3]=os.date("%m")
  time[4]=os.date("%d")
  time[5]=os.date("%H")
  time[6]=os.date("%M")
  time[7]=os.date("%S")
  for i=1,len(time)do
    print(time[i])
  end
  for i=1,7 do
    if visit[i]~=nil and len(visit[i])~=0 then
      print(len(visit[i]),time[i])
      correct[i][1]=len(visit[i])==tonumber(time[i])
    end
  end
end

newlevel.hint={
  {x=1,y=1},
  {x=10,y=1},
  {x=10,y=2},
  {x=1,y=2}
}

return newlevel
