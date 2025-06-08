-- shape equals area  8-1

newlevel={}


newlevel.level_str={
  {"  ",
   " #1"},
  {"  ",
   " #2"},
  {"   ",
   "   ",
   "  #3"},
  {"   ",
   " #4 ",
   "   "},
  {"#1  ",
   "   ",
   "  #2"},
  {" #8   #6 ",
   "       ",
   "       ",
   "       ",
   " #7   #3 "},
  {"   #5   ",
   "       ",
   "   #5   ",
   "       "}
}

function newlevel.LoadLevel()
  tetris={}
  tetris["1"]={
    "1"
  }
  tetris["2"]={
    "11"
  }
  tetris["3"]={
    "01",
    "11"
  }
  tetris["6"]={
    "11",
    "01"
  }
  tetris["7"]={
    "10",
    "11"
  }
  tetris["8"]={
    "11",
    "10"
  }
  tetris["4"]={
    "111",
    "010"
  }
  tetris["5"]={
    "111",
    "100"
  }
end

newlevel.correct_num=2

newlevel.hint={
  {x=1,y=2},
  {x=1,y=1},
  {x=2,y=1}
}
function newlevel.checkVictory()
  rPrint(newlevel.tetris)
  ans=true
  FloodFill()
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str=="#" and not visit_grid[currentPanel][i][j] then
        if not AreaMirror(ToArea(tetris[map[currentPanel][i][j].char]),FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]],"same") then
          ans=false
        end
      end
    end
  end
  correct[currentPanel][1]=isBlock("#")
  correct[currentPanel][2]=ans
end

newlevel.text="Meet the polyominoes."

return newlevel
