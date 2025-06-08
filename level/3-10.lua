--All Shapes Pairs Up

newlevel = {}

newlevel.level_str = {
  { "OO  OO" },
  { "O O", "   ", "O O" },
  { "O  O  O", "       ", "O  O  O" },
  { "O  ", "   ", "  O" },
  { "C S", "   ", "C S" },
  { "S C", "   ", "C S" },
  { "       ", " S C C ", "       ", " C   C ", "       ", " C C S ", "       " },
  {
    "S     S",
    "       ",
    "   S   ",
    "       ",
    "C C C C",
    "       ",
    "   S   ",
    "       ",
    "S     S",
  },
}

newlevel.correct_num = 2

newlevel.text = "If you have played The Witness, octostar may remind you of something."

function newlevel.checkVictory()
  FloodFill()
  correct[currentPanel][1] = isBlock("all")
  local ans = true
  for i = 1, len(FloodFillShapeCount[currentPanel]) do
    for k, v in pairs(FloodFillShapeCount[currentPanel][i]) do
      if k ~= " " and v ~= 2 then
        ans = false
      end
    end
  end
  correct[currentPanel][2] = ans
end

newlevel.hint = {
  { x = 3, y = 1 },
  { x = 4, y = 1 },
}
return newlevel
