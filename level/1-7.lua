-- one type is cover, other is block

newlevel = {}

newlevel.level_str = {
  { "CSSC" },
  { "C C", "   ", "S S" },
  { "C S", "   ", "S C" },
  { "C S C", "S C S" },
  { "CSC", "   ", "CSC" },
  { "SCS", "   ", "SCS" },
  { "S C S", "CCCCC", "S C S" },
}
newlevel.correct_num = 2

function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("C") ~= isCover("S")
  correct[currentPanel][2] = isBlock("S") ~= isBlock("C")
end
newlevel.hint = {
  { x = 2, y = 1 },
  { x = 3, y = 1 },
}

newlevel.text = "Not all level have a rule about start point."
return newlevel
