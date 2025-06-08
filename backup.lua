for i=1,len(str)do
  for j=1,len(str[i])do
    if get(str[i],j)=="1" then
      if i==1 then
        love.graphics.line(x+(i-0.5)*delta,y+(j-0.5)*delta-linewidth/2,x+(i-0.5)*delta,y+(j+0.5)*delta+linewidth/2)
      elseif get(str[i-1],j)=="0" then
        love.graphics.line(x+(i-0.5)*delta,y+(j-0.5)*delta-linewidth/2,x+(i-0.5)*delta,y+(j+0.5)*delta+linewidth/2)
      end
      if i==len(str)then
        love.graphics.line(x+(i+0.5)*delta,y+(j-0.5)*delta-linewidth/2,x+(i+0.5)*delta,y+(j+0.5)*delta+linewidth/2)
      elseif get(str[i+1],j)=="0" then
        love.graphics.line(x+(i+0.5)*delta,y+(j-0.5)*delta-linewidth/2,x+(i+0.5)*delta,y+(j+0.5)*delta+linewidth/2)
      end
      if j==1 then
        love.graphics.line(x+(i-0.5)*delta-linewidth/2,y+(j-0.5)*delta,x+(i+0.5)*delta+linewidth/2,y+(j-0.5)*delta)
      elseif get(str[i],j-1)=="0" then
        love.graphics.line(x+(i-0.5)*delta-linewidth/2,y+(j-0.5)*delta,x+(i+0.5)*delta+linewidth/2,y+(j-0.5)*delta)
      end
      if j==len(str[1]) then
        love.graphics.line(x+(i-0.5)*delta-linewidth/2,y+(j+0.5)*delta,x+(i+0.5)*delta+linewidth/2,y+(j+0.5)*delta)
      elseif get(str[i],j+1)=="0" then
        love.graphics.line(x+(i-0.5)*delta-linewidth/2,y+(j+0.5)*delta,x+(i+0.5)*delta+linewidth/2,y+(j+0.5)*delta)
      end
    end
  end
end

for i=1,len(str)do
  for j=1,len(str[i])do
    if get(str[i],j)=="1" then
      if i==1 then
        love.graphics.line(x+(i-0.5)*delta+linewidth/2,y+(j-0.5)*delta,x+(i-0.5)*delta+linewidth/2,y+(j+0.5)*delta)
      elseif get(str[i-1],j)=="0" then
        love.graphics.line(x+(i-0.5)*delta+linewidth/2,y+(j-0.5)*delta,x+(i-0.5)*delta+linewidth/2,y+(j+0.5)*delta)
      end
      if i==len(str)then
        love.graphics.line(x+(i+0.5)*delta-linewidth/2,y+(j-0.5)*delta,x+(i+0.5)*delta-linewidth/2,y+(j+0.5)*delta)
      elseif get(str[i+1],j)=="0" then
        love.graphics.line(x+(i+0.5)*delta-linewidth/2,y+(j-0.5)*delta,x+(i+0.5)*delta-linewidth/2,y+(j+0.5)*delta)
      end
      if j==1 then
        love.graphics.line(x+(i-0.5)*delta,y+(j-0.5)*delta+linewidth/2,x+(i+0.5)*delta,y+(j-0.5)*delta+linewidth/2)
      elseif get(str[i],j-1)=="0" then
        love.graphics.line(x+(i-0.5)*delta,y+(j-0.5)*delta+linewidth/2,x+(i+0.5)*delta,y+(j-0.5)*delta+linewidth/2)
      end
      if j==len(str[1]) then
        love.graphics.line(x+(i-0.5)*delta,y+(j+0.5)*delta-linewidth/2,x+(i+0.5)*delta,y+(j+0.5)*delta-linewidth/2)
      elseif get(str[i],j+1)=="0" then
        love.graphics.line(x+(i-0.5)*delta,y+(j+0.5)*delta-linewidth/2,x+(i+0.5)*delta,y+(j+0.5)*delta-linewidth/2)
      end
    end
  end
end

love.graphics.setColor(backcolor)
for i=1,len(grid)do
  for j=1,len(grid[i])do
    if grid[i][j] then
      if i==1 then
      elseif grid[i-1][j] then
        love.graphics.line(x+(i-0.5)*delta+linewidth/2,y+(j-0.5)*delta+linewidth,x+(i-0.5)*delta+linewidth/2,y+(j+0.5)*delta-linewidth)
      end
      if i==len(str)then
      elseif grid[i+1][j] then
        love.graphics.line(x+(i+0.5)*delta-linewidth/2,y+(j-0.5)*delta+linewidth,x+(i+0.5)*delta-linewidth/2,y+(j+0.5)*delta-linewidth)
      end
      if j==1 then
      elseif grid[i][j-1] then
        love.graphics.line(x+(i-0.5)*delta+linewidth,y+(j-0.5)*delta+linewidth/2,x+(i+0.5)*delta-linewidth,y+(j-0.5)*delta+linewidth/2)
      end
      if j==len(str[1]) then
      elseif grid[i][j+1] then
        love.graphics.line(x+(i-0.5)*delta+linewidth,y+(j+0.5)*delta-linewidth/2,x+(i+0.5)*delta-linewidth,y+(j+0.5)*delta-linewidth/2)
      end
    end
  end
end
love.graphics.setColor(frontcolor)
