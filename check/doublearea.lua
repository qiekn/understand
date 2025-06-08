function DoubleArea(area)
  local area2 = {}
  for i = 1, len(area) do
    table.insert(area2, { x = area[i].x * 2, y = area[i].y * 2 })
    table.insert(area2, { x = area[i].x * 2 + 1, y = area[i].y * 2 })
    table.insert(area2, { x = area[i].x * 2 + 1, y = area[i].y * 2 + 1 })
    table.insert(area2, { x = area[i].x * 2, y = area[i].y * 2 + 1 })
  end
  return area2
end

function BoostArea(area, nn)
  local area2 = {}
  for i = 1, len(area) do
    for j = 0, nn - 1 do
      for k = 0, nn - 1 do
        table.insert(area2, { x = area[i].x * nn + j, y = area[i].y * nn + k })
      end
    end
  end
  return area2
end
