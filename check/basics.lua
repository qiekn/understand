function isEnd(str)
  if len(visit[currentPanel]) == 0 then
    return false
  end
  pos = getlast(visit[currentPanel])
  return match(pos.x, pos.y, str)
end

function isStart(str)
  if len(visit[currentPanel]) == 0 then
    return false
  end
  pos = visit[currentPanel][1]
  return match(pos.x, pos.y, str)
end

function isCover(str)
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if match(i, j, str) and not visit_grid[currentPanel][i][j] then
        return false
      end
    end
  end
  return true
end

function isBlock(str)
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if match(i, j, str) and visit_grid[currentPanel][i][j] then
        return false
      end
    end
  end
  return true
end

function NotStrIsCover(str)
  str = str .. " "
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if (not match(i, j, str)) and not visit_grid[currentPanel][i][j] then
        return false
      end
    end
  end
  return true
end

function NotStrIsBlock(str)
  str = str .. " "
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if (not match(i, j, str)) and visit_grid[currentPanel][i][j] then
        return false
      end
    end
  end
  return true
end

function match(arg1, arg2, arg3)
  local str1
  local str2
  if arg3 == nil then
    str1 = arg1
    str2 = { arg2 }
  else
    str1 = map[currentPanel][arg1][arg2].str
    if str1 ~= " " then
    end
    if type(arg3) == "string" then
      str2 = { arg3 }
    else
      str2 = arg3
    end
  end
  local ans = true
  for i = 1, len(str2) do
    if str2[i] == "all" then
      ans = ans and (str1 ~= " ")
    elseif str2[i] == "corner" then
      ans = ans and (arg1 == 1 or arg1 == mapW[currentPanel]) and (arg2 == 1 or arg2 == mapH[currentPanel])
    elseif str2[i] == "edge" then
      ans = ans and (arg1 == 1 or arg1 == mapW[currentPanel]) ~= (arg2 == 1 or arg2 == mapH[currentPanel])
    elseif str2[i] == "center" then
      ans = ans and not (arg1 == 1 or arg1 == mapW[currentPanel]) and not (arg2 == 1 or arg2 == mapH[currentPanel])
    elseif get(str2[i], 1, 4) == "near" then
      local s = get(str2[i], 5, 5)
      if s == "+" then
        ans = ans and (Near(arg1, arg2, get(str2[i], 6, len(str2[i]))) > 0)
      else
        ans = ans and (Near(arg1, arg2, get(str2[i], 6, len(str2[i]))) == tonumber(s))
      end
    elseif get(str2[i], 1, 4) == "diag" then
      local s = get(str2[i], 5, 5)
      if s == "+" then
        ans = ans and (Diag(arg1, arg2, get(str2[i], 6, len(str2[i]))) > 0)
      else
        ans = ans and (Diag(arg1, arg2, get(str2[i], 6, len(str2[i]))) == tonumber(s))
      end
    elseif get(str2[i], 1, 5) == "above" then
      ans = ans and string.find(get(str2[i], 6, len(str2[i])), Shape({ x = arg1, y = arg2 + 1 })) ~= nil
    elseif get(str2[i], 1, 5) == "below" then
      ans = ans and string.find(get(str2[i], 6, len(str2[i])), Shape({ x = arg1, y = arg2 - 1 })) ~= nil
    elseif get(str2[i], 1, 5) == "right" then
      ans = ans and string.find(get(str2[i], 6, len(str2[i])), Shape({ x = arg1 - 1, y = arg2 })) ~= nil
    elseif get(str2[i], 1, 4) == "left" then
      ans = ans and string.find(get(str2[i], 5, len(str2[i])), Shape({ x = arg1 + 1, y = arg2 })) ~= nil
    else
      ans = ans and string.find(str2[i], str1) ~= nil
    end
  end
  return ans
end

function Near(arg1, arg2, ss)
  local ans = 0
  if string.find(ss, Shape({ x = arg1 - 1, y = arg2 })) ~= nil then
    ans = ans + 1
  end
  if string.find(ss, Shape({ x = arg1 + 1, y = arg2 })) ~= nil then
    ans = ans + 1
  end
  if string.find(ss, Shape({ x = arg1, y = arg2 - 1 })) ~= nil then
    ans = ans + 1
  end
  if string.find(ss, Shape({ x = arg1, y = arg2 + 1 })) ~= nil then
    ans = ans + 1
  end
  return ans
end

function Diag(arg1, arg2, ss)
  local ans = 0
  if string.find(ss, Shape({ x = arg1 - 1, y = arg2 - 1 })) ~= nil then
    ans = ans + 1
  end
  if string.find(ss, Shape({ x = arg1 + 1, y = arg2 - 1 })) ~= nil then
    ans = ans + 1
  end
  if string.find(ss, Shape({ x = arg1 + 1, y = arg2 + 1 })) ~= nil then
    ans = ans + 1
  end
  if string.find(ss, Shape({ x = arg1 - 1, y = arg2 + 1 })) ~= nil then
    ans = ans + 1
  end
  return ans
end

function isPrime(n)
  if n == 1 then
    return false
  end
  for i = 2, n - 1 do
    if n % i == 0 then
      return false
    end
  end
  return true
end

function isAlter(c1, c2)
  local flag = 0
  for i = 1, len(visit[currentPanel]) do
    if match(map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str, c1) then
      if flag == 1 then
        return false
      end
      flag = 1
    end
    if match(map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str, c2) then
      if flag == 2 then
        return false
      end
      flag = 2
    end
  end
  return true
end

function CountShape(countspace)
  shape_cnt = {}
  shape_cover_cnt = {}
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if map[currentPanel][i][j].str ~= " " or countspace == true then
        if shape_cnt[map[currentPanel][i][j].str] == nil then
          shape_cnt[map[currentPanel][i][j].str] = 0
        end
        shape_cnt[map[currentPanel][i][j].str] = shape_cnt[map[currentPanel][i][j].str] + 1
        if visit_grid[currentPanel][i][j] then
          if shape_cover_cnt[map[currentPanel][i][j].str] == nil then
            shape_cover_cnt[map[currentPanel][i][j].str] = 0
          end
          shape_cover_cnt[map[currentPanel][i][j].str] = shape_cover_cnt[map[currentPanel][i][j].str] + 1
        end
      end
    end
  end
end

function GetVisitOrder()
  visit_order = {}
  for i = 1, mapW[currentPanel] do
    visit_order[i] = {}
    for j = 1, mapH[currentPanel] do
      visit_order[i][j] = 0
    end
  end
  for i = 1, len(visit[currentPanel]) do
    visit_order[visit[currentPanel][i].x][visit[currentPanel][i].y] = i
  end
end
