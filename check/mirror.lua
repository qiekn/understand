function AreaMaxMin(area)
  local maxX=0
  local maxY=0
  local minX=10000
  local minY=10000
  for k,v in pairs(area) do
    maxX=max(v.x,maxX)
    minX=min(v.x,minX)
    maxY=max(v.y,maxY)
    minY=min(v.y,minY)
  end
  return maxX,minX,maxY,minY
end

function AreaMirror(area1,area2,xx,yy,mode)
  if(len(area1)~=len(area2))then
    return false
  end
  if(yy==nil)then
    mode=xx
    local maxX,minX,maxY,minY=AreaMaxMin(area1)
    local maxX2,minX2,maxY2,minY2=AreaMaxMin(area2)
    if(mode=="same")then
      xx=minX-minX2
      yy=minY-minY2
    elseif(mode=="reverse")then
      xx=maxX+minX2
      yy=maxY+minY2
    elseif(mode=="horizontal")then
      xx=minX+maxX2
      yy=minY-minY2
    elseif(mode=="vertical")then
      xx=minX-minX2
      yy=minY+maxY2
    elseif(mode=="clockwise")then
      xx=minX-minY2
      yy=maxY+minX2
    elseif(mode=="anticlockwise")then
      xx=maxX+minY2
      yy=minY-minX2
    end
  end
  local area1_s={}
  local area2_s={}
  for i=1,len(area1)do
    area1_s[i]={x=area1[i].x,y=area1[i].y}
    if(mode=="same")then
      area2_s[i]={x=area2[i].x+xx,y=area2[i].y+yy}
    elseif(mode=="horizontal")then
      area2_s[i]={x=-area2[i].x+xx,y=area2[i].y+yy}
    elseif(mode=="vertical")then
      area2_s[i]={x=area2[i].x+xx,y=-area2[i].y+yy}
    elseif(mode=="reverse")then
      area2_s[i]={x=-area2[i].x+xx,y=-area2[i].y+yy}
    elseif(mode=="clockwise")then
      area2_s[i]={x=area2[i].y+xx,y=-area2[i].x+yy}
    elseif(mode=="anticlockwise")then
      area2_s[i]={x=-area2[i].y+xx,y=area2[i].x+yy}
    end
  end
  table.sort(area1_s,cmp_xy)
  table.sort(area2_s,cmp_xy)
  for i=1,len(area1_s)do
    if area1_s[i].x~=area2_s[i].x or area1_s[i].y~=area2_s[i].y then
      return false
    end
  end
  return true
end

function cmp_xy(a,b)
  if(a.y<b.y) then
    return true
  end
  if(a.y==b.y)and(a.x<b.x)then
    return true
  end
  return false
end

function AreaMirrorWithShape(area1,area2,xx,yy,mode)
  if(len(area1)~=len(area2))then
    return false
  end
  local area1_s={}
  local area2_s={}
  for i=1,len(area1)do
    area1_s[i]={x=area1[i].x,y=area1[i].y}
    if(mode=="same")then
      area2_s[i]={x=area2[i].x+xx,y=area2[i].y+yy}
    elseif(mode=="horizontal")then
      area2_s[i]={x=-area2[i].x+xx,y=area2[i].y+yy}
    elseif(mode=="vertical")then
      area2_s[i]={x=area2[i].x+xx,y=-area2[i].y+yy}
    elseif(mode=="reverse")then
      area2_s[i]={x=-area2[i].x+xx,y=-area2[i].y+yy}
    end
    local s1=Shape(area1_s[i])
    local s2=Shape(area2_s[i])
    if s1~=s2 then
      return false
    end
  end
  table.sort(area1_s,cmp_xy)
  table.sort(area2_s,cmp_xy)
  for i=1,len(area1_s)do
    if area1_s[i].x~=area2_s[i].x or area1_s[i].y~=area2_s[i].y then
      return false
    end
  end
  return true
end

function ToArea(tetris_str)
  local area={}
  for i=1,len(tetris_str)do
    for j=1,len(tetris_str[i])do
      if get(tetris_str[i],j)=="1" then
        table.insert(area,{x=j,y=i})
      end
    end
  end
  return area
end
