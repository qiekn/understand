-- pre end is next start

newlevel={}

newlevel.level_str={
  {"C S",
   " U ",
   "S  "},
  {"US ",
   "SUS",
   " SU"},
  {"SUS",
   " U ",
   "SU "},
  {" S ",
   "UUU",
   " S "},
  {" S ",
   "   ",
   "   "}
}
newlevel.correct_num=3

function newlevel.checkVictory()
  if len(visit[currentPanel])==0 then
    return
  end
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isBlock("U")
  if currentPanel~=5 then
    for i=1,3 do
      for j=1,3 do
        if map[currentPanel+1][i][j].str=="C" then
          map[currentPanel+1][i][j].str=" "
        end
      end
    end
    if map[currentPanel+1][getlast(visit[currentPanel]).x][getlast(visit[currentPanel]).y].str==" "then
      map[currentPanel+1][getlast(visit[currentPanel]).x][getlast(visit[currentPanel]).y].str="C"
    end
    currentPanel=currentPanel+1
    newlevel.checkVictory()
    currentPanel=currentPanel-1
  end
end

function newlevel.ResetPanel()
  if currentPanel~=5 then
    for i=1,3 do
      for j=1,3 do
        if map[currentPanel+1]~=nil then
          if map[currentPanel+1][i][j].str=="C" then
            map[currentPanel+1][i][j].str=" "
          end
        end
      end
    end
    currentPanel=currentPanel+1
    if map[currentPanel+1]~=nil then
      newlevel0.checkVictory()
    end
    currentPanel=currentPanel-1
  end
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}

newlevel.text="Dotted line is a lie."
return newlevel
