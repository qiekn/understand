function cut_solve(area, num, isRotate)
  if len(area) % num ~= 0 then
    return false
  end
  if num == 1 then
    return true
  end
  local cut_area = {}
  for i = -1, len(area) / num do
    cut_area[i] = {}
  end
  cut_area[0][0] = true
  area_bottomleft = getBottomLeft(area)
  maxX, minX, maxY, minY = AreaMaxMin(area)
  area_grid0 = {}
  for i = 1, len(area) do
    if area_grid0[area[i].x - area_bottomleft.x] == nil then
      area_grid0[area[i].x - area_bottomleft.x] = {}
    end
    area_grid0[area[i].x - area_bottomleft.x][area[i].y - area_bottomleft.y] = true
  end
  area_grid0[maxX - minX + 1] = {}
  area_grid0[-1] = {}
  return try_cut(cut_area, 1, num, area, isRotate)
end

function try_cut(cut_area, nn, num, area, isRotate)
  if nn * num == len(area) then
    --print_grid(cut_area)
    shapes = {}
    for i = 1, num do
      shapes[i] = {}
      for k, v in pairs(cut_area) do
        for k2, v2 in pairs(v) do
          if v2 == true then
            table.insert(shapes[i], { x = k, y = k2 })
          end
        end
      end
    end
    return tetris_solve(area, shapes, isRotate)
  end
  local marks = {}
  for k, v in pairs(cut_area) do
    for k2, v2 in pairs(v) do
      if cut_area[k][k2] == true then
        local x = k
        local y = k2 - 1
        if (x > 0 or (x == 0 and y > 0)) and cut_area[x][y] == nil and area_grid0[x][y] == true then
          cut_area[x][y] = true
          table.insert(marks, { x = x, y = y })
          if try_cut(cut_area, nn + 1, num, area, isRotate) then
            return true
          end
          cut_area[x][y] = false
        end
        local x = k + 1
        local y = k2
        if (x > 0 or (x == 0 and y > 0)) and cut_area[x][y] == nil and area_grid0[x][y] == true then
          cut_area[x][y] = true
          table.insert(marks, { x = x, y = y })
          if try_cut(cut_area, nn + 1, num, area, isRotate) then
            return true
          end
          cut_area[x][y] = false
        end
        local x = k
        local y = k2 + 1
        if (x > 0 or (x == 0 and y > 0)) and cut_area[x][y] == nil and area_grid0[x][y] == true then
          cut_area[x][y] = true
          table.insert(marks, { x = x, y = y })
          if try_cut(cut_area, nn + 1, num, area, isRotate) then
            return true
          end
          cut_area[x][y] = false
        end
        local x = k - 1
        local y = k2
        if (x > 0 or (x == 0 and y > 0)) and cut_area[x][y] == nil and area_grid0[x][y] == true then
          cut_area[x][y] = true
          table.insert(marks, { x = x, y = y })
          if try_cut(cut_area, nn + 1, num, area, isRotate) then
            return true
          end
          cut_area[x][y] = false
        end
      end
    end
  end
  for i = 1, len(marks) do
    cut_area[marks[i].x][marks[i].y] = nil
  end
  return false
end

function tetris_solve(area, shapes, isRotate)
  area_grid = {}
  total_size = 0
  shapes_rotate = {}
  for i = 1, len(area) do
    if area_grid[area[i].x] == nil then
      area_grid[area[i].x] = {}
    end
    area_grid[area[i].x][area[i].y] = true
  end
  for i = 1, len(shapes) do
    shapes_rotate[i] = {}
    total_size = total_size + len(shapes[i])
    shapes_rotate[i].able = true
    shapes_rotate[i][1] = {}
    for j = 1, len(shapes[i]) do
      shapes_rotate[i][1][j] = { x = shapes[i][j].x, y = shapes[i][j].y }
    end
    shapes_rotate[i][1].bottomleft = getBottomLeft(shapes_rotate[i][1])
    if shapes[i].rotate == true or isRotate == true then
      if not AreaMirror(shapes_rotate[i][1], shapes_rotate[i][1], "clockwise") then
        shapes_rotate[i][2] = {}
        for j = 1, len(shapes[i]) do
          shapes_rotate[i][2][j] = { x = shapes[i][j].y, y = -shapes[i][j].x }
        end
        shapes_rotate[i][2].bottomleft = getBottomLeft(shapes_rotate[i][2])
        if not AreaMirror(shapes_rotate[i][1], shapes_rotate[i][1], "reverse") then
          shapes_rotate[i][3] = {}
          for j = 1, len(shapes[i]) do
            shapes_rotate[i][3][j] = { x = -shapes[i][j].x, y = -shapes[i][j].y }
          end
          shapes_rotate[i][3].bottomleft = getBottomLeft(shapes_rotate[i][3])
          shapes_rotate[i][4] = {}
          for j = 1, len(shapes[i]) do
            shapes_rotate[i][4][j] = { x = -shapes[i][j].y, y = shapes[i][j].x }
          end
          shapes_rotate[i][4].bottomleft = getBottomLeft(shapes_rotate[i][4])
        end
      end
    end
  end
  if total_size ~= len(area) then
    return false
  end
  return try_tetris(area_grid, shapes_rotate, 0)
end

function try_tetris(grid, shapes, nn)
  if len(shapes) == nn then
    return true
  end
  --print(nn)
  for k, v in pairs(grid) do
    for k2, v2 in pairs(v) do
      --  print(k,k2,v2)
    end
  end

  local grid_bottomleft = getGridBottomLeft(grid)
  for i = 1, len(shapes) do
    if shapes[i].able then
      shapes[i].able = false
      for t = 1, len(shapes[i]) do
        if isValid(grid, grid_bottomleft, shapes[i][t]) then
          for j = 1, len(shapes[i][t]) do
            grid[grid_bottomleft.x - shapes[i][t].bottomleft.x + shapes[i][t][j].x][grid_bottomleft.y - shapes[i][t].bottomleft.y + shapes[i][t][j].y] =
              false
          end
          if try_tetris(grid, shapes, nn + 1) then
            return true
          end
          for j = 1, len(shapes[i][t]) do
            grid[grid_bottomleft.x - shapes[i][t].bottomleft.x + shapes[i][t][j].x][grid_bottomleft.y - shapes[i][t].bottomleft.y + shapes[i][t][j].y] =
              true
          end
        end
      end
      shapes[i].able = true
    end
  end
  return false
end

function getBottomLeft(area)
  local ans = {}
  ans.x = 10000
  ans.y = 10000
  for i = 1, len(area) do
    if area[i].x < ans.x or (area[i].x == ans.x and area[i].y < ans.y) then
      ans.x = area[i].x
      ans.y = area[i].y
    end
  end
  return ans
end

function getGridBottomLeft(grid)
  local ans = {}
  ans.x = 10000
  ans.y = 10000
  for k, v in pairs(grid) do
    for k2, v2 in pairs(v) do
      if (k < ans.x or (k == ans.x and k2 < ans.y)) and v2 == true then
        ans = { x = k, y = k2 }
      end
    end
  end
  return ans
end

function isValid(grid, grid_bottomleft, shape)
  for j = 1, len(shape) do
    if grid[grid_bottomleft.x - shape.bottomleft.x + shape[j].x] == nil then
      return false
    end
    if
      grid[grid_bottomleft.x - shape.bottomleft.x + shape[j].x][grid_bottomleft.y - shape.bottomleft.y + shape[j].y]
      ~= true
    then
      return false
    end
  end
  return true
end
