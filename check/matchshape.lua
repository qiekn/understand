function IsRectangle(area)
  local maxX,minX,maxY,minY=AreaMaxMin(area)
  for i=minX,maxX do
    for j=minY,maxY do
      if not AreaHasPos(area,{x=i,y=j}) then
        return -1
      end
    end
  end
  return maxX-minX+1,maxY-minY+1
end

function isLShape(area,XequalsY)
  local maxX,minX,maxY,minY=AreaMaxMin(area)
  if maxX==minX or maxY==minY then
    return "none"
  end
  if XequalsY==true and maxX-minX~=maxY-minY then
    return "none"
  end
  local top=0
  local bottom=0
  local left=0
  local right=0
  local center=0
  for i=minX,maxX do
    for j=minY,maxY do
      if AreaHasPos(area,{x=i,y=j}) then
        if(i==minX)then
          left=left+1
        end
        if(i==maxX)then
          right=right+1
        end
        if(j==minY)then
          bottom=bottom+1
        end
        if(j==maxY)then
          top=top+1
        end
        if i~=minX and i~=maxX and j~=minY and j~=maxY then
          center=center+1
        end
      end
    end
  end
  if center>0 then
    return "none"
  elseif left==1 and right==maxY-minY+1 and top==1 and bottom==maxX-minX+1 then
    return "bottomright"
  elseif right==1 and left==maxY-minY+1 and top==1 and bottom==maxX-minX+1 then
    return "bottomleft"
  elseif left==1 and right==maxY-minY+1 and bottom==1 and top==maxX-minX+1 then
    return "topright"
  elseif right==1 and left==maxY-minY+1 and bottom==1 and top==maxX-minX+1 then
    return "topleft"
  else
    return "none"
  end
end
