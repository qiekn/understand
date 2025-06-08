function GetDirection()
  direction = {}
  for i = 2, len(visit[currentPanel]) do
    local p1 = visit[currentPanel][i]
    local p2 = visit[currentPanel][i - 1]
    if p1.x == p2.x + 1 then
      direction[i - 1] = "R"
    elseif p1.x == p2.x - 1 then
      direction[i - 1] = "L"
    elseif p1.y == p2.y + 1 then
      direction[i - 1] = "D"
    elseif p1.y == p2.y - 1 then
      direction[i - 1] = "U"
    end
  end
  direction[len(visit[currentPanel])] = "X"
end

function PointDirection(p1, p2)
  if p1.x == p2.x + 1 and p1.y == p2.y then
    return "R"
  elseif p1.x == p2.x - 1 and p1.y == p2.y then
    return "L"
  elseif p1.y == p2.y + 1 and p1.x == p2.x then
    return "D"
  elseif p1.y == p2.y - 1 and p1.x == p2.x then
    return "U"
  end
  return "X"
end

function matchDirection(dir1, dir2)
  local a1 = true
  local a2 = true
  if type(dir1) == "string" then
    dir1 = StringToDirection(dir1)
  end
  if type(dir2) == "string" then
    dir2 = StringToDirection(dir2)
  end
  if len(dir1) ~= len(dir2) then
    return false
  end
  for i = 1, len(dir1) do
    if dir1[i] ~= dir2[i] then
      a1 = false
    end
    if dir1[i] ~= RotateDirection(dir2[len(dir2) - i + 1], 2) then
      a2 = false
    end
  end
  return (a1 or a2)
end

function matchStartDirection(dir1, dir2, start)
  local a1 = true
  local a2 = true
  if start == nil then
    start = 0
  end
  if type(dir1) == "string" then
    dir1 = StringToDirection(dir1)
  end
  if type(dir2) == "string" then
    dir2 = StringToDirection(dir2)
  end
  if len(dir1) + start > dir2 then
    return false
  end
  for i = 1, len(dir1) do
    if dir1[i] ~= dir2[i + start] then
      a1 = false
    end
    if dir1[i] ~= RotateDirection(dir2[len(dir1) - i + 1 + start], 2) then
      a2 = false
    end
  end
  return (a1 or a2)
end

function RotateDirection(dir, n)
  local dirs = { "R", "D", "L", "U" }
  local tt = 0
  for i = 1, 4 do
    if dirs[i] == dir then
      tt = i
    end
  end
  tt = (tt + n + 3) % 4 + 1
  return dirs[tt]
end

function StringToDirection(str)
  local dir = {}
  for i = 1, len(str) do
    table.insert(dir, get(str, i))
  end
  return dir
end

function DirectionsToLine(line, dir)
  able = {}
  local tot = 0
  for i = 1, len(dir) do
    able[i] = true
    tot = tot + len(dir[i])
  end
  if tot ~= len(line) then
    return false
  end
  return tryDirectionToLine(line, dir, 0, 0)
end

function tryDirectionToLine(line, dir, nn, start)
  if nn == len(dir) then
    return true
  end
  for i = 1, len(dir) do
    if able[i] and matchStartDirection(line, dir[i], start) then
      able[i] = false
      tryDirectionToLine(line, dir, nn + 1, start + len(dir[i]))
      able[i] = true
    end
  end
end
