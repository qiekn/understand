--most is start, least is end

newlevel={}


newlevel.level_str={
  {"C C",
   " S "},
  {"S S",
   " C ",
   "S S"},
  {"S  ",
   "CC ",
   "UUU"},
  {"CSUOC",
   "TUCSS",
   "STSTC"}
}

newlevel.correct_num=2

function newlevel.checkVictory()
  CountShape()
  local mm=0
  local m2=1000
  for k,v in pairs(shape_cnt) do
    if v>mm then
      mm=v
    end
    if v<m2 then
      m2=v
    end
  end
  ans1=""
  ans2=""
  for k,v in pairs(shape_cnt) do
    if v==mm then
      ans1=ans1..k
    end
    if v==m2 then
      ans2=ans2..k
    end
  end
  correct[currentPanel][1]=isStart(ans1)
  correct[currentPanel][2]=isEnd(ans2)
end

newlevel.hint={
  {x=1,y=1},
  {x=1,y=2},
  {x=2,y=2},
}

newlevel.text="Each chapter has a different topic."
return newlevel
