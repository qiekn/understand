--area forms square

newlevel={}

newlevel.level_str={
  {"S  S",
   "    "},
  {"S   ",
   " S  "},
  {"S  ",
   "  S",
   " S "},
  {"S   ",
   "  S ",
   " S  ",
   "   S"},
  {"S S",
   "S S"},
  {"S   S",
   "     ",
   "S   S"},
  {"S  S ",
   "     ",
   " S  S"},
  {"S  S ",
   "    S",
   "  S  "},
  {"S......S...",
   "...........",
   "...........",
   "...S......S"}
}

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=2},
  {x=2,y=2},
  {x=2,y=1},
  {x=3,y=1},
}

function newlevel.checkVictory()
  FloodFill()
  local ans=false
  local tot=0
  shapes={}
  for i=1,len(FloodFillRes[currentPanel]) do
    table.insert(shapes,FloodFillRes[currentPanel][i])
    tot=tot+len(FloodFillRes[currentPanel][i])
  end
  local squarearea={}
  if math.abs(math.sqrt(tot)*math.sqrt(tot)-tot)<0.1 then
    local d=math.floor(math.sqrt(tot)+0.5)
    for i=1,d do
      for j=1,d do
        table.insert(squarearea,{x=i,y=j})
      end
    end
  end
  correct[currentPanel][1]=isBlock("all")
  correct[currentPanel][2]=len(FloodFillRes[currentPanel])==2
  correct[currentPanel][3]=tetris_solve(squarearea,shapes,false)
end
return newlevel
