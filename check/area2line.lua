function AreaToLine(area)
  local able = true
  local ans1 = {}
  if len(area) == 1 then
    return nil
  end
  for i = 1, len(area) do
    local s = 0
    print(area[i].x, area[i].y)
    for j = 1, len(area) do
      if PointDirection(area[i], area[j]) ~= "X" then
        s = s + 1
        print(area[j].x, area[j].y, "???")
      end
    end
    if s == 1 then
      table.insert(ans1, { x = area[i].x, y = area[i].y })
    end
    if s >= 3 then
      print(area[i].x, area[i].y, s, "!!!")
      return nil
    end
  end
  if len(ans1) ~= 2 then
    return nil
  end
  local ans2 = {}
  table.insert(ans2, { x = ans1[1].x, y = ans1[1].y })
  for t = 1, 100 do
    for i = 1, len(area) do
      local aaa = true
      for j = 1, len(ans2) do
        if ans2[j].x == area[i].x and ans2[j].y == area[i].y then
          aaa = false
        end
      end
      if aaa == true then
        if PointDirection(area[i], ans2[len(ans2)]) ~= "X" then
          table.insert(ans2, { x = area[i].x, y = area[i].y })
        end
      end
    end
  end
  return ans2
end
