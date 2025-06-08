JSON = require("JSON")

function save()
  file = io.open ("understand.sav","w")
  screenWidth=love.graphics.getWidth()
  screenHeight=love.graphics.getHeight()
  reveal={}
  for i=1,len(menu_panel) do
    for j=1,len(menu_panel[1]) do
      if puzzle_reveal[i][j]==2 then
        if(menu_panel[i][j]~="XXX")then
          table.insert(reveal,menu_panel[i][j])
        end
      end
    end
  end
  sav={reveal,select,version,level_lines,mute,level_time,isfullscreen,last_panel}
--  a,b=love.filesystem.write("understand.sav",JSON:encode(sav),all)
  drawDebugText=tostring(a)..tostring(b)
  file:write(JSON:encode(sav))
  file:close()
end

function loadsave()
--
  reveal={}
--  str=love.filesystem.read("understand.sav")
  file=io.open ("understand.sav","r")
  str=file:read()
  if(str~=nil)then
--    str=file:read()
    if str=="" then
      return
    end
    sav=JSON:decode(str)
    if type(sav[1])~="table" then
      return
    end
    if sav[3]~=version then
  --    file2=io.open("understand_old.sav","w")
  --    file2:write(str)
  --    file2:close()
    end
    if type(sav[1][1])=="table" then
      menu_panel=ReadCSV("mapold.csv")
      mapWidth=len(menu_panel[1])
      mapHeight=len(menu_panel)
      gamestate="menu"
      local tmp={}
      for i=1,mapWidth do
        tmp[i]={}
        for j=1,mapHeight do
          tmp[i][j]=menu_panel[j][i]
        end
      end
      menu_panel=tmp
      for i=1,mapWidth do
        for j=1,mapHeight do
          if  sav[1][i][j]==2 then
            if(menu_panel[i][j]~="XXX")then
              table.insert(reveal,menu_panel[i][j])
            end
          end
        end
      end
    else
      reveal=sav[1]
    end
    select=sav[2]
    level_lines=sav[4]
    mute=sav[5]
    level_time=sav[6]
    isfullscreen=sav[7]
    last_panel=sav[8]
    if mute==nil or mute==true or mute==false then
      mute=0
    end
    if level_time==nil then
      level_time={}
    end
    if isfullscreen==nil then
      isfullscreen=false
    end
    if last_panel==nil then
      last_panel={}
    end
--    file:close()
  end
end
