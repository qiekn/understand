-- pointed is cover

newlevel = {}

newlevel.level_str = {
  { "   ", " U ", "   " },
  { "   ", "U D", "   " },
  { "   ", "RR ", "   " },
  { ".LL.", "....", ".RR." },
  { ".....", "..L..", ".U.D.", "..R..", "....." },
  { "     ", "RL UD", "     " },
}

newlevel.correct_num = 2

newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("aboveU") and isCover("belowD") and isCover("leftL") and isCover("rightR")
  correct[currentPanel][2] = isBlock("belowU") and isBlock("aboveD") and isBlock("rightL") and isBlock("leftR") -- and isBlock("aboveD") and isBlock("belowL") and isBlock("leftR") and isBlock("rightU")
  --correct[currentPanel][2]=correct[currentPanel][2]and isBlock("aboveL") and isBlock("belowR") and isBlock("leftU") and isBlock("rightD") and isBlock("aboveR") and isBlock("belowU") and isBlock("leftD") and isBlock("rightL")
end
return newlevel
