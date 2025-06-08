function drawText(x, y, str)
  if str == nil then
    return
  end
  love.graphics.printf(str, x - 2000, y - font:getHeight() * 0.35, 4000, "center")
end

function drawTextLeft(x, y, str)
  if str == nil then
    return
  end
  uiSize = math.min(screenWidth / 10, screenHeight / 6)
  local w = screenWidth - x - uiSize / 2
  if w < 200 then
    w = 200
  end
  love.graphics.printf(str, x, y, w, "left")
end

function setScreen(width, height)
  --  love.window.setFullscreen(true,"desktop")
  --  love.window.setFullscreen(false)
end

function drawCircle(x, y, r, isFill)
  if isFill == true then
    love.graphics.circle("fill", x, y, r + love.graphics.getLineWidth() / 2)
  else
    love.graphics.circle("line", x, y, r)
  end
end

function drawDottedLine(x1, y1, x2, y2, delta, delta2)
  --  print(x1,y1,x2,y2,delta,delta2)
  local length = math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
  if delta == nil then
    delta = linewidth * 4
  end
  delta = length / math.floor(length / (delta * 1.5) + 0.5) / 1.5
  if delta2 == nil then
    delta2 = delta / 2
  end
  dx = delta / 2 / length * (x2 - x1)
  dy = delta / 2 / length * (y2 - y1)
  dx2 = (delta + delta2) / length * (x2 - x1)
  dy2 = (delta + delta2) / length * (y2 - y1)
  --  print("dx",dx,dx2,"dy",dy,dy2)
  for i = 1, math.floor(length / (delta + delta2) + 0.5) do
    love.graphics.line(x1 + (i - 1) * dx2 + dx, y1 + (i - 1) * dy2 + dy, x1 + i * dx2 - dx, y1 + i * dy2 - dy)
  end
end

function drawDottedSquare(x, y, r)
  --print(x,y,r)
  drawDottedLine(x - r, y - r, x + r, y - r, boxwidth / 8, boxwidth / 8)
  drawDottedLine(x + r, y - r, x + r, y + r, boxwidth / 8, boxwidth / 8)
  drawDottedLine(x + r, y + r, x - r, y + r, boxwidth / 8, boxwidth / 8)
  drawDottedLine(x - r, y + r, x - r, y - r, boxwidth / 8, boxwidth / 8)
  --print(x,y,r)
end

function drawTick(x, y, r)
  points = { x - r, y + r * 0.3, x - r * 0.3, y + r, x + r, y - 0.4 * r }
  love.graphics.line(points)
end

function drawPolygon(x, y, r, num, rotate, isFill)
  points = {}
  for i = 1, num do
    rr = rotate + 2 * math.pi / num * i
    table.insert(points, math.cos(rr) * r + x)
    table.insert(points, math.sin(rr) * r + y)
  end
  if isFill == true then
    love.graphics.polygon("fill", points)
  end
  love.graphics.polygon("line", points)
end

function drawRect(x, y, r1, r2, rotate, isFill)
  points = {}
  table.insert(points, x + math.cos(rotate) * r1 - math.sin(rotate) * r2)
  table.insert(points, y + math.sin(rotate) * r1 + math.cos(rotate) * r2)
  table.insert(points, x - math.cos(rotate) * r1 - math.sin(rotate) * r2)
  table.insert(points, y - math.sin(rotate) * r1 + math.cos(rotate) * r2)
  table.insert(points, x - math.cos(rotate) * r1 + math.sin(rotate) * r2)
  table.insert(points, y - math.sin(rotate) * r1 - math.cos(rotate) * r2)
  table.insert(points, x + math.cos(rotate) * r1 + math.sin(rotate) * r2)
  table.insert(points, y + math.sin(rotate) * r1 - math.cos(rotate) * r2)
  if isFill == true then
    love.graphics.polygon("fill", points)
  end
  love.graphics.polygon("line", points)
end

function drawSprite(x, y, r, sprite)
  local w, h = sprite:getDimensions()
  love.graphics.draw(sprite, x - r, y - r, 0, r / w * 2, r / h * 2)
end

function drawCross(x, y, r1, r2, rotate0, isFill)
  points = {}
  p1 = {}
  p2 = {}
  for i = 1, 4 do
    rotate = rotate0 + math.pi / 2 * (i - 1)
    x1 = r1
    y1 = -r2
    x2 = x + x1 * math.cos(rotate) - y1 * math.sin(rotate)
    y2 = y + x1 * math.sin(rotate) + y1 * math.cos(rotate)
    table.insert(points, x2)
    table.insert(points, y2)
    if i % 2 == 1 then
      table.insert(p1, x2)
      table.insert(p1, y2)
    else
      table.insert(p2, x2)
      table.insert(p2, y2)
    end
    x1 = r1
    y1 = r2
    x2 = x + x1 * math.cos(rotate) - y1 * math.sin(rotate)
    y2 = y + x1 * math.sin(rotate) + y1 * math.cos(rotate)
    table.insert(points, x2)
    table.insert(points, y2)
    if i % 2 == 1 then
      table.insert(p1, x2)
      table.insert(p1, y2)
    else
      table.insert(p2, x2)
      table.insert(p2, y2)
    end
    x1 = r2
    y1 = r2
    rot = rotate + math.pi / 2 * (i - 1)
    x2 = x + x1 * math.cos(rotate) - y1 * math.sin(rotate)
    y2 = y + x1 * math.sin(rotate) + y1 * math.cos(rotate)
    table.insert(points, x2)
    table.insert(points, y2)
  end
  love.graphics.polygon("line", points)
  if isFill then
    love.graphics.polygon("fill", p1)
    love.graphics.polygon("fill", p2)
  end
end

function drawStar(x, y, r, inner, num, rotate, isFill)
  points = {}
  pt2 = {}
  for i = 1, num do
    tri = {}
    rr = rotate + 2 * math.pi / num * (i + 0.5)
    table.insert(points, math.cos(rr) * r * inner + x)
    table.insert(points, math.sin(rr) * r * inner + y)
    table.insert(tri, math.cos(rr) * r * inner + x)
    table.insert(tri, math.sin(rr) * r * inner + y)
    table.insert(tri, math.cos(rr + math.pi / num) * r + x)
    table.insert(tri, math.sin(rr + math.pi / num) * r + y)
    table.insert(tri, math.cos(rr + 2 * math.pi / num) * r * inner + x)
    table.insert(tri, math.sin(rr + 2 * math.pi / num) * r * inner + y)
    table.insert(pt2, math.cos(rr) * r * inner + x)
    table.insert(pt2, math.sin(rr) * r * inner + y)
    table.insert(pt2, math.cos(rr + math.pi / num) * r + x)
    table.insert(pt2, math.sin(rr + math.pi / num) * r + y)
    if isFill == true then
      love.graphics.polygon("fill", tri)
    end
  end
  if isFill == true then
    love.graphics.polygon("fill", points)
  end
  love.graphics.polygon("line", pt2)
end

function drawSquare(x, y, r, fill)
  if fill then
    love.graphics.rectangle(
      "fill",
      x - r / 2 - love.graphics.getLineWidth() / 2,
      y - r / 2 - love.graphics.getLineWidth() / 2,
      r + love.graphics.getLineWidth(),
      r + love.graphics.getLineWidth()
    )
  else
    love.graphics.rectangle("line", x - r / 2, y - r / 2, r, r)
  end
end

function drawTetris2(x0, y0, r, str, fill)
  local grid = toGrid(str)
  local m = math.max(len(grid), len(grid[1]))
  if m < 5 then
    m = 5
  end
  local delta = r / m * 2
  local x = x0 - delta * (len(grid) + 1) / 2
  local y = y0 - delta * (len(grid[1]) + 1) / 2
  for i = 1, len(grid) do
    for j = 1, len(grid[i]) do
      if grid[i][j] then
        drawSquare(x + i * delta, y + j * delta, delta - linewidth / 2 + 1, fill)
      end
    end
  end
end

function drawTetris(x0, y0, r, str, fill)
  local grid = toGrid(str)
  local m = math.max(len(grid), len(grid[1]))
  if m < 5 then
    m = 5
  end
  local delta = r / m * 2
  local x = x0 - delta * (len(grid) + 1) / 2
  local y = y0 - delta * (len(grid[1]) + 1) / 2
  if fill then
    for i = 1, len(grid) do
      for j = 1, len(grid[i]) do
        if grid[i][j] then
          drawSquare(x + i * delta, y + j * delta, delta - linewidth + 1, fill)
        end
      end
    end
  else
    --love.timer.sleep(1000)
    --for i=1,len(grid)
  end
  local dir = { { 1, 0 }, { 0, 1 }, { -1, 0 }, { 0, -1 } }
  local left = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { 0, -1 } }
  local right = { { 0, -1 }, { 0, 0 }, { -1, 0 }, { -1, -1 } }
  local corner =
    { { linewidth / 2, linewidth / 2 }, { -linewidth / 2, linewidth / 2 }, { -linewidth / 2, -linewidth / 2 }, {
      linewidth / 2,
      -linewidth / 2,
    } }
  local corner2 =
    { { -linewidth / 2, linewidth / 2 }, { -linewidth / 2, -linewidth / 2 }, { linewidth / 2, -linewidth / 2 }, {
      linewidth / 2,
      linewidth / 2,
    } }
  FloodFill2(grid)
  for i = 1, len(grid) do
    for j = 1, len(grid[i]) do
      --      print(i,j,FloodFillAns2[i][j])
    end
  end
  for i, v in pairs(FloodFillRes2) do
    if i ~= -30000 then
      local mx = 10000
      local my = 10000
      for j = 1, len(FloodFillRes2[i]) do
        if FloodFillRes2[i][j].x < mx or (FloodFillRes2[i][j].x == mx and FloodFillRes2[i][j].y < my) then
          mx = FloodFillRes2[i][j].x
          my = FloodFillRes2[i][j].y
        end
      end
      local pt0_x = mx
      local pt0_y = my
      local next = 1
      local points = {}
      --table.insert(points,x+pt0_x*delta-delta*0.5+corner[next][1])
      --table.insert(points,y+pt0_y*delta-delta*0.5+corner[next][1])
      table.insert(points, x + pt0_x * delta - delta * 0.5)
      table.insert(points, y + pt0_y * delta - delta * 0.5)
      repeat
        mx = mx + dir[next][1]
        my = my + dir[next][2]
        if FloodFillAns2[mx + left[next][1]][my + left[next][2]] ~= i then
          next = next + 1
          if next == 5 then
            next = 1
          end
          --table.insert(points,x+mx*delta-delta*0.5+corner[next][1])
          --table.insert(points,y+my*delta-delta*0.5+corner[next][2])
          table.insert(points, x + mx * delta - delta * 0.5)
          table.insert(points, y + my * delta - delta * 0.5)
        elseif FloodFillAns2[mx + right[next][1]][my + right[next][2]] == i then
          next = next - 1
          if next == 0 then
            next = 4
          end
          --    table.insert(points,x+mx*delta-delta*0.5+corner[next][1])
          --  table.insert(points,y+my*delta-delta*0.5+corner[next][2])
          table.insert(points, x + mx * delta - delta * 0.5)
          table.insert(points, y + my * delta - delta * 0.5)
        end
      until mx == pt0_x and my == pt0_y
      love.graphics.line(points)
    end
  end
end

function drawTetrisGrid(x0, y0, r, grid, fill)
  local m = math.max(len(grid), len(grid[1]))
  --  if m<7 then
  m = 11
  --  end
  local delta = r / m * 2
  local x = x0 - delta * (len(grid) + 1) / 2
  local y = y0 - delta * (len(grid[1]) + 1) / 2
  if fill then
    for i = 1, len(grid) do
      for j = 1, len(grid[i]) do
        if grid[i][j] then
          drawSquare(x + i * delta, y + j * delta, delta - linewidth + 1, fill)
        end
      end
    end
  else
    for i = 1, len(grid) do
      for j = 1, len(grid[i]) do
        if grid[i][j] then
          --          love.graphics.rectangle("fill", x+i*delta-linewidth/4, y+j*delta-linewidth/4, linewidth/2, linewidth/2)
        end
      end
    end
  end
  local dir = { { 1, 0 }, { 0, 1 }, { -1, 0 }, { 0, -1 } }
  local left = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { 0, -1 } }
  local right = { { 0, -1 }, { 0, 0 }, { -1, 0 }, { -1, -1 } }
  local corner =
    { { linewidth / 2, linewidth / 2 }, { -linewidth / 2, linewidth / 2 }, { -linewidth / 2, -linewidth / 2 }, {
      linewidth / 2,
      -linewidth / 2,
    } }
  local corner2 =
    { { -linewidth / 2, linewidth / 2 }, { -linewidth / 2, -linewidth / 2 }, { linewidth / 2, -linewidth / 2 }, {
      linewidth / 2,
      linewidth / 2,
    } }
  FloodFill2(grid)
  for i = 1, len(grid) do
    for j = 1, len(grid[i]) do
      --      print(i,j,FloodFillAns2[i][j])
    end
  end
  for i, v in pairs(FloodFillRes2) do
    if i ~= -30000 then
      local mx = 10000
      local my = 10000
      for j = 1, len(FloodFillRes2[i]) do
        if FloodFillRes2[i][j].x < mx or (FloodFillRes2[i][j].x == mx and FloodFillRes2[i][j].y < my) then
          mx = FloodFillRes2[i][j].x
          my = FloodFillRes2[i][j].y
        end
      end
      local pt0_x = mx
      local pt0_y = my
      local next = 1
      local points = {}
      --table.insert(points,x+pt0_x*delta-delta*0.5+corner[next][1])
      --table.insert(points,y+pt0_y*delta-delta*0.5+corner[next][1])
      table.insert(points, x + pt0_x * delta - delta * 0.5)
      table.insert(points, y + pt0_y * delta - delta * 0.5)
      repeat
        mx = mx + dir[next][1]
        my = my + dir[next][2]
        if FloodFillAns2[mx + left[next][1]][my + left[next][2]] ~= i then
          next = next + 1
          if next == 5 then
            next = 1
          end
          --table.insert(points,x+mx*delta-delta*0.5+corner[next][1])
          --table.insert(points,y+my*delta-delta*0.5+corner[next][2])
          table.insert(points, x + mx * delta - delta * 0.5)
          table.insert(points, y + my * delta - delta * 0.5)
        elseif FloodFillAns2[mx + right[next][1]][my + right[next][2]] == i then
          next = next - 1
          if next == 0 then
            next = 4
          end
          --    table.insert(points,x+mx*delta-delta*0.5+corner[next][1])
          --  table.insert(points,y+my*delta-delta*0.5+corner[next][2])
          table.insert(points, x + mx * delta - delta * 0.5)
          table.insert(points, y + my * delta - delta * 0.5)
        end
      until mx == pt0_x and my == pt0_y
      love.graphics.line(points)
    end
  end
end

function FloodFill2(grid)
  FloodFillRes2 = {}
  FloodFillAns2 = {}
  for i = 0, len(grid) + 1 do
    FloodFillAns2[i] = {}
    for j = 0, len(grid[1]) + 1 do
      if i == 0 or j == 0 or i == len(grid) + 1 or j == len(grid[1]) + 1 then
        FloodFillAns2[i][j] = -20000
      elseif grid[i][j] then
        FloodFillAns2[i][j] = (i - 1) * len(grid[1]) + j + 10000
      else
        FloodFillAns2[i][j] = -10000 --(i-1)*len(grid[1])+j+20000
      end
    end
  end
  FloodFillCnt = 0
  for i = 1, len(grid) do
    for j = 1, len(grid[1]) do
      if FloodFillAns2[i][j] > 10000 then
        FloodFillCnt = FloodFillCnt + 1
        TryFloodFill2(i, j, FloodFillCnt, grid, false)
      elseif FloodFillAns2[i][j] == -10000 then
        FloodFillCnt = FloodFillCnt + 1
        FloodFillFlag = true
        TryFloodFill2(i, j, -FloodFillCnt, grid, true)
        if not FloodFillFlag then
          for i1 = 1, len(grid) do
            for j1 = 1, len(grid[1]) do
              if FloodFillAns2[i1][j1] == -FloodFillCnt then
                FloodFillAns2[i1][j1] = -30000
              end
            end
          end
        end
      end
    end
  end
  for i = 1, len(grid) do
    for j = 1, len(grid[1]) do
      if FloodFillRes2[FloodFillAns2[i][j]] == nil then
        FloodFillRes2[FloodFillAns2[i][j]] = {}
      end
      table.insert(FloodFillRes2[FloodFillAns2[i][j]], { x = i, y = j })
    end
  end
end

function TryFloodFill2(x, y, k, grid, inner)
  if x <= 0 or y <= 0 or x > len(grid) or y > len(grid[1]) then
    FloodFillFlag = false
    return
  end
  if FloodFillAns2[x][y] == k or (inner == grid[x][y]) then
    return
  end
  FloodFillAns2[x][y] = k
  TryFloodFill2(x - 1, y, k, grid, inner)
  TryFloodFill2(x + 1, y, k, grid, inner)
  TryFloodFill2(x, y + 1, k, grid, inner)
  TryFloodFill2(x, y - 1, k, grid, inner)
end

function toGrid(str)
  local grid = {}
  for i = 1, len(str) do
    for j = 1, len(str[1]) do
      if i == 1 then
        grid[j] = {}
      end
      if get(str[i], j) == "1" then
        grid[j][i] = true
      else
        grid[j][i] = false
      end
    end
  end
  return grid
end

function drawRoundSquare(x, y, r, c, fill)
  if fill == true then
    love.graphics.rectangle("fill", x - r, y - (r - c), 2 * r, 2 * (r - c))
    love.graphics.rectangle("fill", x - (r - c), y - r, 2 * (r - c), 2 * r)
    love.graphics.arc("fill", x - (r - c), y - (r - c), c, math.pi, 3 * math.pi / 2)
    love.graphics.arc("fill", x + (r - c), y - (r - c), c, -math.pi / 2, 0)
    love.graphics.arc("fill", x + (r - c), y + (r - c), c, 0, math.pi / 2)
    love.graphics.arc("fill", x - (r - c), y + (r - c), c, math.pi / 2, math.pi)
  else
    love.graphics.rectangle("line", x - r, y - (r - c), 2 * r, 2 * (r - c))
    love.graphics.rectangle("line", x - (r - c), y - r, 2 * (r - c), 2 * r)
    love.graphics.arc("line", x - (r - c), y - (r - c), c, math.pi, 3 * math.pi / 2)
    love.graphics.arc("line", x + (r - c), y - (r - c), c, -math.pi / 2, 0)
    love.graphics.arc("line", x + (r - c), y + (r - c), c, 0, math.pi / 2)
    love.graphics.arc("line", x - (r - c), y + (r - c), c, math.pi / 2, math.pi)
  end
end

function drawRoundRect(x, y, width, height, fill)
  if width < height then
    drawCircle(x, y, height / 2, fill)
    return
  end
  points = {}
  table.insert(points, x - width / 2)
  table.insert(points, y - height / 2)
  table.insert(points, x + width / 2)
  table.insert(points, y - height / 2)
  for i = 1, 49 do
    rr = math.pi * (-0.5 + i / 50)
    table.insert(points, x + width / 2 + math.cos(rr) * height / 2)
    table.insert(points, y + math.sin(rr) * height / 2)
  end
  table.insert(points, x + width / 2)
  table.insert(points, y + height / 2)
  table.insert(points, x - width / 2)
  table.insert(points, y + height / 2)
  for i = 1, 49 do
    rr = math.pi * (-0.5 + i / 50)
    table.insert(points, x - width / 2 - math.cos(rr) * height / 2)
    table.insert(points, y - math.sin(rr) * height / 2)
  end
  love.graphics.polygon("line", points)
  if fill == true then
    love.graphics.polygon("fill", points)
  end
  if fill == true then
    --    love.graphics.rectangle("fill",x-width/2,y-height/2,width,height)
    --  love.graphics.circle("fill", x-width/2, y, height/2)
    --  love.graphics.circle("fill", x+width/2, y, height/2)
  end
end

function drawHeart(x, y, r)
  love.graphics.polygon("fill", x - r, y, x, y + r, x + r, y)
  love.graphics.circle("fill", x - 0.5 * r, y - 0.2 * r, 0.6 * r)
  love.graphics.circle("fill", x + 0.5 * r, y - 0.2 * r, 0.6 * r)
  --love.graphics.arc("fill",x-0.5*r,y-0.2*r,0.6*r,-math.pi*1.2,0)
  --love.graphics.arc("fill",x+0.5*r,y-0.2*r,0.6*r,-math.pi,math.pi*0.2)
end

function drawArrow(x, y, r, dir, isFill)
  dx = { 1, 0, -1, -1, 0 }
  dy = { 0, 1, 1, -1, -1 }
  d = {}
  for i = 1, 5 do
    if dir == 1 then
      d[2 * i - 1] = dy[i] * r + x
      d[2 * i] = -dx[i] * r + y
    elseif dir == 2 then
      d[2 * i - 1] = -dx[i] * r + x
      d[2 * i] = -dy[i] * r + y
    elseif dir == 3 then
      d[2 * i - 1] = -dy[i] * r + x
      d[2 * i] = dx[i] * r + y
    elseif dir == 4 then
      d[2 * i - 1] = dx[i] * r + x
      d[2 * i] = dy[i] * r + y
    end
  end
  if isFill == true then
    love.graphics.polygon("fill", d)
  else
    love.graphics.polygon("line", d)
  end
end

function drawSmallLine(x0, y0, r, str, fill)
  local minx = 0
  local maxx = 0
  local miny = 0
  local maxy = 0
  local xx = 0
  local yy = 0
  local pts = { { x = xx, y = yy } }
  for i = 1, len(str) do
    if get(str, i) == "U" then
      yy = yy - 1
    end
    if get(str, i) == "D" then
      yy = yy + 1
    end
    if get(str, i) == "L" then
      xx = xx - 1
    end
    if get(str, i) == "R" then
      xx = xx + 1
    end
    minx = min(xx, minx)
    miny = min(yy, miny)
    maxx = max(xx, maxx)
    maxy = max(yy, maxy)
    table.insert(pts, { x = xx, y = yy })
  end
  local grid = {}
  for i = 0, (maxx - minx) * 2 + 1 do
    grid[i] = {}
    for j = 0, (maxy - miny) * 2 + 1 do
      grid[i][j] = -1
    end
  end
  local delta = r / 11
  local x1 = x0 - delta * (maxx + minx + 1)
  local y1 = y0 - delta * (maxy + miny + 1)
  for i = 1, len(pts) do
    drawSquare(x1 + delta * (pts[i].x * 2 + 1), y1 + delta * (pts[i].y * 2 + 1), delta, fill)
  end
  for i = 2, len(pts) do
    local s1 = x1 + delta * (pts[i - 1].x * 2 + 1)
    local s2 = y1 + delta * (pts[i - 1].y * 2 + 1)
    local s3 = x1 + delta * (pts[i].x * 2 + 1)
    local s4 = y1 + delta * (pts[i].y * 2 + 1)
    local pp = 0.75
    love.graphics.line(
      s1 * pp + s3 * (1 - pp),
      s2 * pp + s4 * (1 - pp),
      s3 * pp + s1 * (1 - pp),
      s4 * pp + s2 * (1 - pp)
    )
  end

  --[[  for i=1,(maxx-minx)*2+1 do
    grid[i]={}
    for j=1,(maxy-miny)*2+1 do
      grid[i][j]=false
    end
  end
  grid[pts[1].x*2-minx*2+1][pts[1].y*2-miny*2+1]=true
  for i=2,len(pts) do
    grid[pts[i-1].x+pts[i].x-minx*2+1][pts[i-1].y+pts[i].y-miny*2+1]=true
    grid[pts[i].x*2-minx*2+1][pts[i].y*2-miny*2+1]=true
  end
  for i=1,(maxx-minx)*2+1 do
    for j=1,(maxy-miny)*2+1 do
      --print(i,j,grid[i][j])
    end
  end
  drawTetrisGrid(x0,y0,r*0.5,grid,true)]]
end
