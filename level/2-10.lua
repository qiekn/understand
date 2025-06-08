--four space between two shapes

newlevel={}


newlevel.level_str={
  {"C  ",
   "  S"},
  {"O  O",
   "    "},
  {"UT ",
   "   "},
  {"S    U    C"},
  {"     ",
   " SUC ",
   "     "},
  {"D  L",
   "    ",
   "    ",
   "R  U"},
  {"C  UO ",
   "      ",
   "      ",
   "  T D ",
   " S    ",
   " R L  "}

}

newlevel.correct_num=2

newlevel.text="Don't waste an empty space."

function newlevel.checkVictory()
  correct[currentPanel][1]=isCover("all")
  local tmp=-10000
  local ans=true
  for i=1,len(visit[currentPanel]) do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str~=" " then
      if(i-tmp~=5)and(tmp~=-10000)then
        ans=false
      end
      tmp=i
    end
  end
  correct[currentPanel][2]=ans
end

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=2,y=2},
  {x=2,y=1},
  {x=3,y=1},
  {x=3,y=2}
}
return newlevel
