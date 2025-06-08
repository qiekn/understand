-- corner equals number of triangle

newlevel={}

tetris={}

newlevel.level_str={
  {" S",
   "CU"},
  {"     ",
   "CU US",
   "     "},
  {"C    ",
   " U U ",
   "    S"},
  {"     ",
   "  U  ",
   "C U S",
   "  U  ",
   "     "},
  {"     ",
   " U U ",
   "C   S",
   " U U ",
   "     "},
  {"C   S",
   " U U ",
   "     ",
   " U U ",
   "     "},
  {"UUUUU",
   "     ",
   "C   S",
   "     ",
   "     "},
}

newlevel.correct_num=4

newlevel.hint={
  {x=1,y=2},
  {x=1,y=1},
  {x=2,y=1}
}

newlevel.CircleColor={1,1,1,{2,9}}

function newlevel.checkVictory()
  CountShape()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isBlock("U")
  GetDirection()
  local ans=0
  for i=2,len(visit[currentPanel])-1 do
    if direction[i-1]~=direction[i] then
      ans=ans+1
      print(i)
    end
  end
  correct[currentPanel][4]=(shape_cnt["U"]==ans)
end
return newlevel
