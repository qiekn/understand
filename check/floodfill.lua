FloodFillAns = {}
FloodFillRes = {}
FloodFillShapeCount = {}
FloodFillAreaSize = {}

function FloodFill()
  FloodFillRes[currentPanel] = {}
  FloodFillAns[currentPanel] = {}
  for i = 1, mapW[currentPanel] do
    FloodFillAns[currentPanel][i] = {}
    for j = 1, mapH[currentPanel] do
      if visit_grid[currentPanel][i][j] then
        FloodFillAns[currentPanel][i][j] = -1
      else
        FloodFillAns[currentPanel][i][j] = (i - 1) * mapH[currentPanel] + j + 10000
      end
    end
  end
  FloodFillCnt = 0
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if FloodFillAns[currentPanel][i][j] > 10000 then
        FloodFillCnt = FloodFillCnt + 1
        TryFloodFill(i, j, FloodFillCnt)
      end
    end
  end
  for i = 1, mapW[currentPanel] do
    for j = 1, mapH[currentPanel] do
      if FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]] == nil then
        FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]] = {}
      end
      table.insert(FloodFillRes[currentPanel][FloodFillAns[currentPanel][i][j]], { x = i, y = j })
    end
  end
  FloodFillShapeCount[currentPanel] = {}
  for k, v in pairs(FloodFillRes[currentPanel]) do
    FloodFillShapeCount[currentPanel][k] = {}
    for k2, v2 in pairs(v) do
      if FloodFillShapeCount[currentPanel][k][map[currentPanel][v2.x][v2.y].str] == nil then
        FloodFillShapeCount[currentPanel][k][map[currentPanel][v2.x][v2.y].str] = 1
      else
        FloodFillShapeCount[currentPanel][k][map[currentPanel][v2.x][v2.y].str] = FloodFillShapeCount[currentPanel][k][map[currentPanel][v2.x][v2.y].str]
          + 1
      end
    end
  end
  --[[  for j=1,mapH[currentPanel] do
    ans=""
    for i=1,mapW[currentPanel] do
      ans=ans..FloodFillAns[currentPanel][i][j].." "
    end
    print(ans)
  end
  for i=1,FloodFillCnt do
    print(i)
    for j=1,len(FloodFillRes[currentPanel][i]) do
      print(FloodFillRes[currentPanel][i][j].x,FloodFillRes[currentPanel][i][j].y)
    end
  end]]
end

function TryFloodFill(x, y, k)
  if x <= 0 or y <= 0 or x > mapW[currentPanel] or y > mapH[currentPanel] then
    return
  end
  if FloodFillAns[currentPanel][x][y] == k or visit_grid[currentPanel][x][y] then
    return
  end
  FloodFillAns[currentPanel][x][y] = k
  TryFloodFill(x - 1, y, k)
  TryFloodFill(x + 1, y, k)
  TryFloodFill(x, y + 1, k)
  TryFloodFill(x, y - 1, k)
end
