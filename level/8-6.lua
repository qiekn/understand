-- shape difference is area, 8-5

newlevel={}

function newlevel.LoadLevel()
  tetris={}
  tetris["a"]={
    "1111","0011"
  }
  tetris["b"]={
    "1111","1111"
  }
  tetris["c"]={
    "1"
  }
  tetris["d"]={
    "11"
  }
  tetris["e"]={
    "111",
    "111",
    "111"
  }
  tetris["f"]={
    "11",
    "11"
  }
  tetris["1"]={
    "11"
  }
  tetris["2"]={
    "11",
    "11"
  }
  tetris["3"]={
    "1",
  }
  tetris["4"]={
    "010",
    "111"
  }
  tetris["5"]={
    "010",
    "010",
    "111"
  }
  tetris["6"]={
    "1111",
  }
end

newlevel.level_str={
  {"  ",
   "#2#1"},
  {"  ",
   "#2#3"},
  {"   ",
   "#4 #3"},
  {"   ",
   "#5 #1"},
  {"   ",
   "#5 #3"},
  {"#6 #6",
   "   ",
   "#3 #3"},
  {"#a  #b",
   "    ",
   "    ",
   "#c  #d"},
  {"..#e..",
   ".....",
   "#f...#f",
   ".....",
   "..#e.."}
}



newlevel.correct_num=3

newlevel.hint={
  {x=1,y=1},
  {x=2,y=1}
}
function newlevel.checkVictory()
  ans=true
  ans2=true
  FloodFill()
  for i=1,len(FloodFillRes[currentPanel])do
    local shapes={}
    for j=1,len(FloodFillRes[currentPanel][i])do
      if map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].str=="#" then
        table.insert(shapes,ToArea(tetris[map[currentPanel][FloodFillRes[currentPanel][i][j].x][FloodFillRes[currentPanel][i][j].y].char]))
      end
    end
--    rPrint(shapes)
    if len(shapes)~=2 then
      ans2=false
    end
    ans3=false
    for j=1,len(shapes)do
      for k=1,len(shapes)do
        if len(shapes[j])-len(shapes[k])==len(FloodFillRes[currentPanel][i])then
          if tetris_solve(shapes[j],{shapes[k],FloodFillRes[currentPanel][i]},true) then
            ans3=true
          end
        end
      end
    end
    ans=ans and ans3
  end
  correct[currentPanel][1]=isBlock("#")
  correct[currentPanel][2]=ans2
  correct[currentPanel][3]=ans
end

newlevel.text="Satisfy rule 2 before rule 3."

return newlevel
