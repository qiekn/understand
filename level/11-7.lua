-- near most empty to near least empty

newlevel={}

newlevel.level_str={
  {"O  ",
   " O ",
   "   "},
  {"O....",
   ".....",
   "O.O..",
   ".....",
   "....."},
  {"....O",
   ".O...",
   ".....",
   "...O.",
   "O...."},
  {"..O..",
   ".O.O.",
   "O...O",
   ".O.O.",
   "..O.."},
  {"O.O..",
   ".....",
   "OO.O.",
   ".....",
   "O...O"},
  {".OOO.",
   "O...O",
   ".....",
   ".....",
   "....."},
  {".....",
   "..O..",
   "OOOO.",
   "..O..",
   "....."}
}

newlevel.correct_num=2

newlevel.hint={
  {x=1,y=1},
  {x=2,y=1},
  {x=2,y=2}
}

function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("all")
  local m=0
  local ans=true
  for i=1,len(visit[currentPanel])do
    local x=visit[currentPanel][i].x
    local y=visit[currentPanel][i].y
    if map[currentPanel][x][y].str~=" " then
      local s=0
      if x>1 and map[currentPanel][x-1][y].str==" " then
        s=s+1
      end
      if y>1 and map[currentPanel][x][y-1].str==" " then
        s=s+1
      end
      if x<len(map[currentPanel]) and map[currentPanel][x+1][y].str==" " then
        s=s+1
      end
      if y<len(map[currentPanel][1]) and map[currentPanel][x][y+1].str==" " then
        s=s+1
      end
      if s<m then
        print(s,m,"!")
        ans=false
      else
        m=s
      end
    end
  end
  correct[currentPanel][2]=ans
end
return newlevel
