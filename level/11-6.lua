-- empty near shape is cover, empty not near shape is block

newlevel={}

newlevel.level_str={
  {"   ",
   " O ",
   "   "},
  {".....",
   ".....",
   ".O.O.",
   ".....",
   "....."},
  {".....",
   ".O...",
   ".....",
   "...O.",
   "....."},
  {".....",
   ".O.O.",
   ".....",
   ".O...",
   "....."},
  {".....",
   "..O..",
   ".O.O.",
   "..O..",
   "....."},
}

newlevel.correct_num=2

function newlevel.checkVictory()
  local a1=true
  local a2=true
  for i=1,len(map[currentPanel])do
    for j=1,len(map[currentPanel][i])do
      if map[currentPanel][i][j].str==" " then
        local f=true
        for u=i-1,i+1 do
          for v=j-1,j+1 do
            if u>0 and u<=len(map[currentPanel]) and v>0 and v<=len(map[currentPanel][1])then
              if map[currentPanel][u][v].str~=" " then
                f=false
              end
            end
          end
        end
        if not f and visit_grid[currentPanel][i][j]==false then
          a1=false
        end
        if f and visit_grid[currentPanel][i][j]==true then
          a2=false
        end
      end
    end
  end
  correct[currentPanel][1]=a1
  correct[currentPanel][2]=a2
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1},
  {x=3,y=3},
  {x=1,y=3},
  {x=1,y=2}
}
return newlevel
