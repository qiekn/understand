-- circle is start, square is end, star is cover, triangle is block

newlevel = {}

newlevel.level_str = {
  { "C S" },
  { "C T", "   ", "U S" },
  { "T U", "   ", "C S" },
  { "CTTT", "TTUT", "UTTT", "UTTS" },
  { "TSTST", "TTTTT", "TTUTT", "TTTTT", "TTCTT" },
  { "CT....U", ".U.U.U.", "..CU.T.", ".U.U.U.", "...TCU.", ".UUU.U.", "..T...S" },
}
newlevel.correct_num = 4
newlevel.hideUi = true
function newlevel.checkVictory()
  correct[currentPanel][1] = isStart("C")
  correct[currentPanel][2] = isEnd("S")
  correct[currentPanel][3] = isCover("T")
  correct[currentPanel][4] = isBlock("U")
end
newlevel.hint = {
  { x = 1, y = 1 },
  { x = 3, y = 1 },
}

newlevel.text = "There's nothing new in this one."
return newlevel
