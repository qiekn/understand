-- arrow is pre and next, same arrow can't be seperate

newlevel = {}

newlevel.level_str = {
  { "   ", " U ", "   " },
  { "   ", "U U", "   " },
  { "     ", "  R  ", "  R  ", "  R  ", "     " },
  { "     ", "  R  ", "  R  ", "  L  ", "  L  ", "     " },
  { "     ", "  R  ", "  L  ", "  R  ", "     " },
  { "     ", "  R  ", "U   D", "  R  ", "     " },
  {
    ".....",
    ".....",
    ".U.R.",
    ".....",
    ".....",
    ".R.U.",
    ".....",
    ".....",
    ".U.R.",
    ".....",
    ".....",
  },
  {
    "................",
    "................",
    ".UU..DD..LL..RR.",
    "................",
    "................",
  },
}

newlevel.correct_num = 3

newlevel.hint = {
  { x = 2, y = 3 },
  { x = 2, y = 1 },
}
function newlevel.checkVictory()
  correct[currentPanel][1] = isCover("ULRD")
  local ans = true
  for i = 1, len(visit[currentPanel]) do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "D" then
      if
        i == 1
        or visit[currentPanel][i - 1].x ~= visit[currentPanel][i].x
        or visit[currentPanel][i - 1].y ~= visit[currentPanel][i].y - 1
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "R" then
      if
        i == 1
        or visit[currentPanel][i - 1].x ~= visit[currentPanel][i].x - 1
        or visit[currentPanel][i - 1].y ~= visit[currentPanel][i].y
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "U" then
      if
        i == 1
        or visit[currentPanel][i - 1].x ~= visit[currentPanel][i].x
        or visit[currentPanel][i - 1].y ~= visit[currentPanel][i].y + 1
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "L" then
      if
        i == 1
        or visit[currentPanel][i - 1].x ~= visit[currentPanel][i].x + 1
        or visit[currentPanel][i - 1].y ~= visit[currentPanel][i].y
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "U" then
      if
        i == len(visit[currentPanel])
        or visit[currentPanel][i + 1].x ~= visit[currentPanel][i].x
        or visit[currentPanel][i + 1].y ~= visit[currentPanel][i].y - 1
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "L" then
      if
        i == len(visit[currentPanel])
        or visit[currentPanel][i + 1].x ~= visit[currentPanel][i].x - 1
        or visit[currentPanel][i + 1].y ~= visit[currentPanel][i].y
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "D" then
      if
        i == len(visit[currentPanel])
        or visit[currentPanel][i + 1].x ~= visit[currentPanel][i].x
        or visit[currentPanel][i + 1].y ~= visit[currentPanel][i].y + 1
      then
        ans = false
      end
    end
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str == "R" then
      if
        i == len(visit[currentPanel])
        or visit[currentPanel][i + 1].x ~= visit[currentPanel][i].x + 1
        or visit[currentPanel][i + 1].y ~= visit[currentPanel][i].y
      then
        ans = false
      end
    end
  end

  correct[currentPanel][2] = ans

  local ans2 = true
  for i = 1, len(visit[currentPanel]) - 2 do
    for j = i + 1, len(visit[currentPanel]) - 1 do
      for k = j + 1, len(visit[currentPanel]) do
        if
          map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str ~= " "
          and map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].str ~= " "
          and map[currentPanel][visit[currentPanel][k].x][visit[currentPanel][k].y].str ~= " "
        then
          if
            map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str
              ~= map[currentPanel][visit[currentPanel][j].x][visit[currentPanel][j].y].str
            and map[currentPanel][visit[currentPanel][k].x][visit[currentPanel][k].y].str
              == map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str
          then
            ans2 = false
          end
        end
      end
    end
  end

  correct[currentPanel][3] = ans2
end
return newlevel
