-- pointed shape is cover

newlevel={}


newlevel.level_str={
  {" D ",
   "R L",
   " U "},
  {"   ",
   "RRR",
   "   "},
  {"   ",
   "RUL",
   "   "},
  {"     ",
   "RL UD",
   "     "},
  {"        ",
   "UULLDDRR",
   "        "},
  {"U.R.L",
   ".....",
   "L.U.D",
   ".....",
   "R.D.L"},
}

newlevel.correct_num=2

newlevel.hint={
  {x=2,y=1},
  {x=3,y=1},
  {x=3,y=3},
  {x=1,y=3},
  {x=1,y=1}
}
function newlevel.checkVictory()
  local ans1=true
  local ans2=true
  local cover={}
  for i=1,mapW[currentPanel]do
    cover[i]={}
    for j=1,mapH[currentPanel]do
      cover[i][j]=0
      if map[currentPanel][i][j].str~=" "then
        cover[i][j]=1
      end
    end
  end
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if map[currentPanel][i][j].str~=" "then
        --block
        if map[currentPanel][i][j].str=="U"then
          local k=j-1
          while k>0 and map[currentPanel][i][k].str==" "do
            k=k-1
          end
          if k~=0 then
            print(i,j,k)
            cover[i][k]=2
            --cover
          end
        end
        if map[currentPanel][i][j].str=="D"then
          local k=j+1
          while k<=mapH[currentPanel] and map[currentPanel][i][k].str==" "do
            k=k+1
          end
          if k~=mapH[currentPanel]+1 then
            print(i,j,k)
            cover[i][k]=2
            --cover
          end
        end
        if map[currentPanel][i][j].str=="L"then
          local k=i-1
          while k>0 and map[currentPanel][k][j].str==" "do
            k=k-1
          end
          if k~=0 then
            print(i,j,k)
            cover[k][j]=2
            --cover
          end
        end
        if map[currentPanel][i][j].str=="R"then
          local k=i+1
          while k<=mapW[currentPanel] and map[currentPanel][k][j].str==" "do
            k=k+1
          end
          print(i,j,k)
          if k~=mapW[currentPanel]+1 then
            cover[k][j]=2
            --cover
          end
        end
      end
    end
  end
  for i=1,mapW[currentPanel]do
    for j=1,mapH[currentPanel]do
      if cover[i][j]==1 and visit_grid[currentPanel][i][j] then
        ans2=false
      end
      if cover[i][j]==2 and not visit_grid[currentPanel][i][j] then
        ans1=false
      end
    end
  end
  correct[currentPanel][1]=ans1
  correct[currentPanel][2]=ans2
end
return newlevel
