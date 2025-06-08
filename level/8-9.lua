-- area forms square

newlevel={}

tetris={}

newlevel.level_str={
  {"  ",
   " #1"},
  {"#1  ",
   "   ",
   "  #1"},
  {"  ",
   " #6"},
  {"#2  ",
   "  #2"},
  {"#2..#2",
   "....",
   "....",
   "...#1"},
  {"#2..#2",
   "....",
   "....",
   "#1..#1"},
  {"#2..#1",
   "....",
   "....",
   "#1..#1"},
  {"#5..#7",
   "....",
   "....",
   "#1..#1"},
   {"........",
    "........",
    "..#u..#v..",
    "........",
    "........",
    "..#x..#y..",
    "........",
    "........",
    "..#z..#w..",
    "........",
    "........"},
  {"........",
   "........",
   "..#a..#b..",
   "........",
   "........",
   "..#c..#d..",
   "........",
   "........",
   "..#e..#f..",
   "........",
   "........"}
}

function newlevel.LoadLevel()
  tetris={}
  tetris["1"]={
    "1"
  }
  tetris["2"]={
    "11",
  }
  tetris["3"]={
    "111",
  }
  tetris["4"]={
    "1111",
  }
  tetris["5"]={
    "11",
    "10"
  }
  tetris["6"]={
    "11",
    "11"
  }
  tetris["7"]={
    "01",
    "11"
  }
  tetris["a"]={
    "1"
  }
  tetris["b"]={
    "11","01"
  }
  tetris["c"]={
    "10",
    "11"
  }
  tetris["d"]={
    "11",
    "11"
  }
  tetris["e"]={
    "100",
    "100",
    "111"
  }
  tetris["f"]={
    "111"
  }
  tetris["8"]={
    "100",
    "111"
  }
  tetris["u"]={
    "11","10","11"
  }
  tetris["v"]={
    "11","01"
  }
  tetris["w"]={
    "1"
  }
  tetris["x"]={
    "01",
    "01",
    "11"
  }
  tetris["y"]={
    "11",
    "11"
  }
  tetris["z"]={
    "1"
  }
  tetris["8"]={
    "100",
    "111"
  }
end



newlevel.correct_num=2

newlevel.hint={
  {x=1,y=1},
  {x=2,y=1}
}
function newlevel.checkVictory()
  ans=true
  FloodFill()
  for i=1,len(FloodFillRes[currentPanel])do
    local shapes={}
    local tot=0
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str=="#" then
        table.insert(shapes,ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char]))
        tot=tot+len(getlast(shapes))
        print(tot)
      end
    end
--    rPrint(shapes)
    local ans0=false
    for j=1,10 do
      if tot==j*j then
        area={}
        for k=1,j do
          for t=1,j do
            table.insert(area,{x=k,y=t})
          end
        end
        if tetris_solve(area,shapes,false)then
          ans0=true
        end
      end
    end
    if not ans0 then
      ans=false
    end
  end
  correct[currentPanel][1]=isBlock("#")
  correct[currentPanel][2]=ans
end

newlevel.text="No restriction on area shape."

newlevel.tetris=tetris

return newlevel
