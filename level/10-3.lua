--shape forms area, shape cnt is adjacent num

newlevel={}

newlevel.level_str={
   {"#1#2 ",
    "   "},
   {" #2 ",
    "   ",
    " #2 "},
   {"     ",
    "  #A  ",
    "     "},
   {"   ",
    "  #2",
    "  #1",
    "   "},
   {".....",
    ".....",
    "..#3..",
    ".....",
    "....."},
   {".....",
    ".....",
    "..#2..",
    ".....",
    "....."},
   {".......",
    ".......",
    "..#X.#Y..",
    ".......",
    "......."},
   {".......",
    ".......",
    ".#4.#6.#5.",
    ".......",
    "......."},
   {".......",
    ".......",
    "...#3...",
    ".......",
    "..#8.#3..",
    ".......",
    "......."}
 }

function newlevel.LoadLevel()
  tetris={}
  tetris["1"]={"1"}
  tetris["2"]={"11"}
  tetris["3"]={"111"}
  tetris["8"]={"1111"}
  tetris["4"]={"11","01"}
  tetris["5"]={"11","10"}
  tetris["6"]={"10","11"}
  tetris["A"]={"010","111"}
  tetris["X"]={"100","111"}
  tetris["Y"]={"11","01","01"}
end

newlevel.correct_num=3

newlevel.hint={
  {x=1,y=2},
  {x=3,y=2}
}
newlevel.CircleColor={1,8,5}

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1]=isBlock("all")
  local ans=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="#" then
        local cnt=0
        if i>1 and j>1 then
          if visit_grid[currentPanel][i-1][j-1] then
            cnt=cnt+1
          end
        end
        if i>1 and j<mapH[currentPanel] then
          if visit_grid[currentPanel][i-1][j+1] then
            cnt=cnt+1
          end
        end
        if i<mapW[currentPanel] and j>1 then
          if visit_grid[currentPanel][i+1][j-1] then
            cnt=cnt+1
          end
        end
        if i<mapW[currentPanel] and j<mapH[currentPanel] then
          if visit_grid[currentPanel][i+1][j+1] then
            cnt=cnt+1
          end
        end
        if cnt~=len(ToArea(tetris[map[currentPanel][i][j].char])) then
          ans=false
        end
      end
    end
  end
  ans2=true
  for i=1,len(FloodFillRes[currentPanel])do
    local shapes={}
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str=="#" then
        table.insert(shapes,ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char]))
      end
    end
--    rPrint(shapes)
    if len(shapes)>0 then
      if not tetris_solve(FloodFillRes[currentPanel][i],shapes,false)then
        ans2=false
      end
    end
  end
  correct[currentPanel][2]=ans2
  correct[currentPanel][3]=ans
end

return newlevel
