--spelling

newlevel={}

newlevel.level_str={
  {"C@U@N@D@E@R@S@T@A@N@DS"},
  {"$1.$2.$3.$4.$5.$6",
   "@T@H@E.@W@I@T@N@E@S@S"},
  {"....$7...$9...$8....",
   "..................",
   "@R@O@S@E @I@S @R@E@D.......",
   "@V@I@O@L@E@T @I@S @B@L@U@E....",
   "@F@L@A@G @I@S @W@I@N...",
   "@B@A@B@A @I@S @Y@O@U......."},--18
  {"$f..............",
   "@T@H@E.@Q@U@I@C@K.@B@R@O@W@N",
   "...............",
   "@F@O@X.@J@U@M@P@S.@O@V@E@R.",
   "...............",
   "@T@H@E.@L@A@Z@Y.@D@O@G...",
   "...............",
--   "@P@S.@I.@H@A@V@E.@T@R@I@E@D",
--   "@M@Y @B@E@S@T.@T@O.@D@R@A@W"
  },
  {".............",
   "@A@B@C@D@E@F@G@H@I@J@K@L@M",
   "$a.....$c.....$b",
   "@N@O@P@Q@R@S@T@U@V@W@X@Y@Z",
   "............."},
--[[ {"$k..............",
   "...............",
   "@S@G@D.@P@T@H@B@J.@A@Q@N@V@M",
   "...............",
   "...............",
   "@E@N@W.@I@T@L@O@R.@N@U@D@Q.",
   "...............",
   "...............",
   "@Z.@K@Z@Y@X.@C@N@F....",
   "...............",
   "..............."}]]--
}

--The quick brown fox jumps over a lazy dog
--SGD PTHBJ AQNVM ENW ITLOR NUDQ Z KZYX CNF


newlevel.sprites={}

newlevel.sprites["1"]=love.graphics.newImage("pic/hex.png")
newlevel.sprites["2"]=love.graphics.newImage("pic/round.png")
newlevel.sprites["3"]=love.graphics.newImage("pic/oct.png")
newlevel.sprites["4"]=love.graphics.newImage("pic/tri.png")
newlevel.sprites["5"]=love.graphics.newImage("pic/poly.png")
newlevel.sprites["6"]=love.graphics.newImage("pic/anti.png")
newlevel.sprites["7"]=love.graphics.newImage("pic/baba.png")
newlevel.sprites["8"]=love.graphics.newImage("pic/flag.png")
newlevel.sprites["9"]=love.graphics.newImage("pic/keke.png")
newlevel.sprites["k"]=love.graphics.newImage("pic/key.png")
newlevel.sprites["a"]=love.graphics.newImage("pic/portal2.png")
newlevel.sprites["b"]=love.graphics.newImage("pic/portal.png")
newlevel.sprites["c"]=love.graphics.newImage("pic/heart.png")
newlevel.sprites["f"]=love.graphics.newImage("pic/fez2.png")
newlevel.sprites["p"]=love.graphics.newImage("pic/rose.png")
newlevel.sprites["q"]=love.graphics.newImage("pic/violet.png")

newlevel.correct_num=1

newlevel.hint={
  {x=1,y=1},
  {x=12,y=1}
}
local answer={
  "UNDERSTAND",
  "THEWITNESS",
  "BABAISYOU",
  "FEZ",
  "PORTAL",
  --"BXOGDQ"
}
function newlevel.checkVictory()
  ans=""
  for i=1,len(visit[currentPanel])do
    if map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].str=="@" then
      ans=ans..map[currentPanel][visit[currentPanel][i].x][visit[currentPanel][i].y].char
    end
  end
  correct[currentPanel][1]=(ans==answer[currentPanel])
end

newlevel.text="I have tried my best to draw this."


function newlevel.mouseDraw()
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
--  print(currentPanel,xx,yy)
  local telex,teley=0
  local able=false
  if(currentPanel==5)then
    if(xx==0)and(yy==3)and(lastpos.y==3)and(lastpos.x==1)then
      xx=13
      able=true
      telex,teley=toScreen(13,3)
    end
    if(xx==14)and(yy==3)and(lastpos.y==3)and(lastpos.x==13)then
      print(xx,yy)
      xx=1
      able=true
      telex,teley=toScreen(1,3)
    end
  end
  if(xx>0)and(yy>0)and(xx<=mapWidth)and(yy<=mapHeight)then
    if(dis(xx,yy,lastpos.x,lastpos.y)==1)or able then
      if not (visit_grid[currentPanel][xx][yy])then
        visit_grid[currentPanel][xx][yy]=true
        table.insert(visit[currentPanel],{x=xx,y=yy})
        if able then
          love.mouse.setPosition(telex,teley)
        end
      else
        if(visit[currentPanel][len(visit[currentPanel])-1].x==xx)and(visit[currentPanel][len(visit[currentPanel])-1].y==yy)then
          visit_grid[currentPanel][lastpos.x][lastpos.y]=false
          table.remove(visit[currentPanel])
          if able then
            love.mouse.setPosition(telex,teley)
          end
        end
      end
    end
  end
end

return newlevel
