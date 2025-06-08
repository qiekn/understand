-- empty between different shape is covered once
newlevel={}

newlevel.level_str={
  {"C C"},
  {"C C",
   "   ",
   "S S"},
  {"C C",
   "   ",
   "S U"},
  {"C C",
   "   ",
   "S C"},
  {"C.C.C",
   ".....",
   "S.C.S"},
  {"C.C.S",
   ".....",
   "S.C.C"},
  {"C..C..C",
   "......."},
  {"C...C",
   ".....",
   ".S..S",
   ".....",
   "C...."},
  {"C...C",
   ".....",
   "S...S",
   ".....",
   "C...."},
  {"C...C",
   ".....",
   ".S.S.",
   ".....",
   "C..S."},
  {"......",
   ".C..C.",
   "......",
   "..S..S",
   ".C..C.",
   "......"},
  {"....C..",
   ".CS....",
   "....C..",
   "..S....",
   ".C..S.S",
   ".......",
   ".C..C.."},
  {".......",
   ".C.C.C.",
   ".......",
   ".......",
   ".C...C.",
   "...C...",
   ".C....."}
}

newlevel.correct_num=3

newlevel.hint={
  {x=2,y=1}
}

function newlevel.checkVictory()
  correct[currentPanel][1]=isBlock("all")
  local ans3=true
  local ans2=true
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str~=" " then
        local ch,cnt=Gate(i,j,0,1)
        if(ch==map[currentPanel][i][j].str)and(cnt~=1)then
          print(i,j,0,1,2)
          ans2=false
        end
        if(ch~=map[currentPanel][i][j].str)and(ch~="out!")and(cnt~=0)then
          print(i,j,0,1,3)
          ans3=false
        end
        local ch,cnt=Gate(i,j,0,-1)
        if(ch==map[currentPanel][i][j].str)and(cnt~=1)then
          ans2=false
          print(i,j,0,-1,2)
        end
        if(ch~=map[currentPanel][i][j].str)and(ch~="out!")and(cnt~=0)then
          ans3=false
          print(i,j,0,-1,3)
        end
        local ch,cnt=Gate(i,j,1,0)
        if(ch==map[currentPanel][i][j].str)and(cnt~=1)then
          ans2=false
          print(i,j,1,0,2)
        end
        if(ch~=map[currentPanel][i][j].str)and(ch~="out!")and(cnt~=0)then
          ans3=false
          print(i,j,1,0,3)
        end
        local ch,cnt=Gate(i,j,-1,0)
        if(ch==map[currentPanel][i][j].str)and(cnt~=1)then
          ans2=false
          print(i,j,-1,0,2)
        end
        if(ch~=map[currentPanel][i][j].str)and(ch~="out!")and(cnt~=0)then
          ans3=false
          print(i,j,-1,0,3)
        end
      end
    end
  end
  correct[currentPanel][2]=ans2
  correct[currentPanel][3]=ans3
end

function Gate(x,y,dx,dy)
  local xx=x+dx
  local yy=y+dy
  if Shape(xx,yy)~=" " then
    return Shape(xx,yy),0
  else
    local i1,i2=Gate(xx,yy,dx,dy)
    if visit_grid[currentPanel][xx][yy]==true then
      i2=i2+1
    end
    return i1,i2
  end
end
return newlevel
