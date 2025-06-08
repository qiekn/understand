function len(obj)
  if type(obj)=="table" then
    return table.getn(obj)
  elseif type(obj)=="string" then
    return string.len(obj)
  end
  return -1
end

function get(str,i,j)
  if(j==nil)then
    j=i
  end
  return string.sub(str,i,j)
end

function Shape(pos,p2)
  if(p2~=nil)then
    pos={x=pos,y=p2}
  end
  if pos.x==0 or pos.y==0 or pos.x==mapW[currentPanel]+1 or pos.y==mapH[currentPanel]+1 then
    return "out!"
  end
  return map[currentPanel][pos.x][pos.y].str
end

function getlast(t)
  if type(t)=="table" then
    return t[len(t)]
  elseif type(t)=="string" then
    return get(t,len(t))
  end
  return 0
end

function insert(table1, table2)
  for i,v in pairs(table2) do
    table.insert(table1,v)
  end
end

function getdirection(pos1,pos2)
  if(pos2.x<=0)or(pos2.y<=0)or(pos2.x>mapHeight)or(pos2.y>mapWidth)then
    return "invalid"
  end
	if(pos1.x==pos2.x)and(pos1.y==pos2.y)then
		return "same"
	end
	if(pos1.x==pos2.x)and(pos1.y==pos2.y+1)then
		return "up"
	end
	if(pos1.x==pos2.x)and(pos1.y==pos2.y-1)then
		return "down"
	end
	if(pos1.x==pos2.x-1)and(pos1.y==pos2.y)then
		return "right"
	end
	if(pos1.x==pos2.x+1)and(pos1.y==pos2.y)then
		return "left"
	end
	return "other"
end

function toScreen(i,j)
  return math.floor(mapleft+i*boxwidth),math.floor(maptop+j*boxwidth)
end

function dis(x1,y1,x2,y2)
  return math.abs(x2-x1)+math.abs(y2-y1)
end

function max(a,b)
  if a>b then
    return a
  else
    return b
  end
end

function min(a,b)
  if a<b then
    return a
  else
    return b
  end
end

function haskey(list,val)
  for k,v in pairs(list) do
    if v==val then
      return true
    end
  end
  return false
end

function AreaHasPos(list,val)
  for k,v in pairs(list) do
    if v.x==val.x and v.y==val.y then
      return true
    end
  end
  return false
end
