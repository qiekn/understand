-- move

newlevel={}

newlevel.level_str={
  {"CUS"},
  {"CU.",
   "L.R",
   ".DS"},
  {"...R...",
   "C.....S",
   "...L..."},
  {"C...R",
   ".....",
   ".....",
   "L...S"},
  {"CR.......S"}
}
newlevel.correct_num=3

maptop_modify=0
mapleft_modify=0
function newlevel.SpecialDrawSetting()
  if gamestate=="ready" then
    maptop_modify=0
    mapleft_modify=0
  end
  mapleft=screenWidth/2-boxwidth*(mapWidth+1)/2+boxwidth*mapleft_modify
  maptop=screenHeight/2-boxwidth*(mapHeight+1)/2+boxwidth*maptop_modify
end


function newlevel.checkVictory()
  correct[currentPanel][1]=isStart("C")
  correct[currentPanel][2]=isEnd("S")
  correct[currentPanel][3]=isCover("all")
end

newlevel.hint={
  {x=1,y=1},
  {x=3,y=1}
}

mousedelaytime=-1000
function newlevel.mouseDraw()
  if love.timer.getTime()-mousedelaytime<0.1 then
    return
  end
  lastpos=getlast(visit[currentPanel])

  local x1=love.mouse.getX()
  local y1=love.mouse.getY()
  local x2,y2=toScreen(lastpos.x,lastpos.y)
  local xx=math.floor((x1-mapleft)/boxwidth+0.5)
  local yy=math.floor((y1-maptop)/boxwidth+0.5)
  if math.abs(x1-x2)>math.abs(y1-y2) then
    if(xx>lastpos.x)then
      xx=lastpos.x+1
      yy=lastpos.y
    elseif(xx<lastpos.x)then
      xx=lastpos.x-1
      yy=lastpos.y
    end
  elseif math.abs(x1-x2)<math.abs(y1-y2) then
    if(yy>lastpos.y)then
      yy=lastpos.y+1
      xx=lastpos.x
    elseif(yy<lastpos.y)then
      yy=lastpos.y-1
      xx=lastpos.x
    end
  end
  if(xx>0)and(yy>0)and(xx<=mapWidth)and(yy<=mapHeight)then
    if(dis(xx,yy,lastpos.x,lastpos.y)==1)or able then
      if not (visit_grid[currentPanel][xx][yy])then
        visit_grid[currentPanel][xx][yy]=true
        table.insert(visit[currentPanel],{x=xx,y=yy})
        local dx=0
        local dy=0
        for i=1,len(visit[currentPanel])-1 do
          if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="U" then
            dx=0
            dy=-1
          end
          if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="L" then
            dx=-1
            dy=0
          end
          if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="D" then
            dx=0
            dy=1
          end
          if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="R" then
            dx=1
            dy=0
          end
        end
        xxxx,yyyy=love.mouse.getPosition()
        xxxx=xxxx+dx*boxwidth
        yyyy=yyyy+dy*boxwidth
        mapleft_modify=mapleft_modify+dx
        maptop_modify=maptop_modify+dy
        love.mouse.setPosition(xxxx,yyyy)
        x33,y33=love.mouse.getPosition()
        mousedelaytime=love.timer.getTime()
      else
        if(visit[currentPanel][len(visit[currentPanel])-1].x==xx)and(visit[currentPanel][len(visit[currentPanel])-1].y==yy)then
          visit_grid[currentPanel][lastpos.x][lastpos.y]=false
          table.remove(visit[currentPanel])
          local dx=0
          local dy=0
          for i=1,len(visit[currentPanel]) do
            if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="U" then
              dx=0
              dy=-1
            end
            if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="L" then
              dx=-1
              dy=0
            end
            if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="D" then
              dx=0
              dy=1
            end
            if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="R" then
              dx=1
              dy=0
            end
          end
          xxxx,yyyy=love.mouse.getPosition()
          xxxx=xxxx-dx*boxwidth
          yyyy=yyyy-dy*boxwidth
          mapleft_modify=mapleft_modify-dx
          maptop_modify=maptop_modify-dy
          love.mouse.setPosition(xxxx,yyyy)
          mousedelaytime=love.timer.getTime()
        end
      end
    end
  end
end

return newlevel
