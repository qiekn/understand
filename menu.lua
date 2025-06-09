menu = {}
menu_panel = {}
level_lines = {}
required_levels = {}

select = { x = -100, y = -100 }

fontsize = 0
solve_cnt = {}

mute = 0

level_time = {}

sound_sprite = love.graphics.newImage("assets/images/sound.png")

isfullscreen = false

function menu.draw()
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  maxH = 1
  maxW = 1
  for i = 1, mapWidth do
    for j = 1, mapHeight do
      if puzzle_reveal[i][j] ~= 0 then
        --      if(puzzle_solved[menu_panel[i][j]]~=nil)then
        if i > maxW then
          maxW = i
        end
        if j > maxH then
          maxH = j
        end
      end
    end
  end

  uiSize = math.min(screenWidth / 15, screenHeight / 9)

  boxwidth = screenWidth * 0.8 / maxW
  if screenHeight / maxH * 0.8 < boxwidth then
    boxwidth = screenHeight / maxH * 0.8
  end
  if boxwidth > screenWidth / 6 then
    boxwidth = screenWidth / 6
  end
  if boxwidth > screenHeight / 3 then
    boxwidth = screenHeight / 3
  end
  if boxwidth > 200 then
    boxwidth = (200 + boxwidth) / 2
  end
  local ttt = max((screenWidth - uiSize * 7) / maxW, (screenHeight - uiSize * 3) / maxH)
  if ttt < boxwidth then
    boxwidth = ttt
  end
  linewidth = boxwidth / 20
  if linewidth < 1 then
    linewidth = 1
  end

  mapleft = screenWidth / 2 - boxwidth * (maxW + 1) / 2
  maptop = screenHeight / 2 - boxwidth * (maxH + 1) / 2

  if boxwidth / 4 ~= fontsize then
    fontsize = boxwidth / 4
    if fontsize < 2 then
      fontsize = 2
    end
    font = love.graphics.newFont(FONT_DIR .. "Han.otf", fontsize)
    font2 = love.graphics.newFont(FONT_DIR .. "Han.otf", fontsize * 2)
  end

  backcolor = backcolor_menu

  love.graphics.setBackgroundColor(backcolor)
  love.graphics.setColor(frontcolor)
  love.graphics.setLineStyle("smooth")
  love.graphics.setLineWidth(linewidth)

  for i = 1, mapWidth do
    for j = 1, mapHeight do
      boxX = mapleft + i * boxwidth
      boxY = maptop + j * boxwidth
      love.graphics.setLineWidth(linewidth)
      love.graphics.setFont(font)

      if get(menu_panel[i][j], 1, 2) == "EX" then
        if (puzzle_reveal[i][j] ~= 0) or (AllIsVisible == true) then
          --        if(puzzle_solved[menu_panel[i][j]]~=nil)or(AllIsVisible==true)then
          local ans = string.match(menu_panel[i][j], "%d+")
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          frontcolor = frontcolors[tonumber(ans)]
          love.graphics.setColor(frontcolor)
          drawSquare(boxX, boxY, boxwidth * 0.7, true)
          frontcolor = backcolors[tonumber(ans)]
          love.graphics.setColor(frontcolor)
          if puzzle_reveal[i][j] == 2 then
            drawTick(boxX + 0.1 * boxwidth, boxY + 0.06 * boxwidth, boxwidth * 0.25)
          end
          drawText(boxX, boxY, ans .. "-?")
        end
      elseif menu_panel[i][j] == "END" then
        if (puzzle_reveal[i][j] ~= 0) or (AllIsVisible == true) then
          frontcolor = getBackColor(menu_panel[i][j])
          love.graphics.setColor(frontcolor)
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          frontcolor = getFrontColor(menu_panel[i][j])
          love.graphics.setColor(frontcolor)
          drawText(boxX, boxY, "?")
          if puzzle_reveal[i][j] == 2 then
            drawTick(boxX + 0.1 * boxwidth, boxY + 0.06 * boxwidth, boxwidth * 0.25)
          end
          --          love.graphics.setColor(frontcolor)
          --          drawSquare(boxX,boxY,boxwidth*0.7,true)
        end
        --  elseif(string.find(menu_panel[i][j],"*")~=nil)then
        --[[
        local ans=string.match(menu_panel[i][j],"%d+")
        local ans2=string.match(menu_panel[i][j],"%d+")
        love.graphics.setColor(midcolors[tonumber(ans)])
        drawSquare(boxX,boxY,boxwidth-linewidth+1,true)
        frontcolor=frontcolors[tonumber(ans)]
        love.graphics.setColor(frontcolor)
        drawSquare(boxX,boxY,boxwidth*0.7,true)
        frontcolor=backcolors[tonumber(ans)]
        love.graphics.setColor(frontcolor)
        drawText(boxX,boxY,ans2)]]
        --      elseif menu_panel[i][j]=="Sound" then
        --        frontcolor=getBackColor(menu_panel[i][j])
        --        love.graphics.setColor(frontcolor)
        --        drawSquare(boxX,boxY,boxwidth-linewidth+1,true)
        --      frontcolor=getFrontColor(menu_panel[i][j])
        --    love.graphics.setColor(frontcolor)
        --  drawSprite(boxX,boxY,boxwidth*0.5,sound_sprite)
        --if mute==3 then
        --  love.graphics.line(boxX-boxwidth*0.3,boxY-boxwidth*0.3,boxX+boxwidth*0.3,boxY+boxwidth*0.3)
        --end
      elseif get(menu_panel[i][j], 1, 1) == "#" then
        love.graphics.setLineWidth(linewidth * 4)
        local ans = string.match(menu_panel[i][j], "%d+")
        love.graphics.setColor(midcolors[tonumber(ans)])
        if i ~= 1 and menu_panel[i - 1][j] ~= "XXX" then
          love.graphics.line(boxX, boxY, boxX - boxwidth * 0.5, boxY)
        end
        if i ~= mapWidth and menu_panel[i + 1][j] ~= "XXX" then
          love.graphics.line(boxX, boxY, boxX + boxwidth * 0.5, boxY)
        end
        if j ~= 1 and menu_panel[i][j - 1] ~= "XXX" then
          love.graphics.line(boxX, boxY, boxX, boxY - boxwidth * 0.5)
        end
        if j ~= mapHeight and menu_panel[i][j + 1] ~= "XXX" then
          love.graphics.line(boxX, boxY, boxX, boxY + boxwidth * 0.5)
        end
      elseif len(menu_panel[i][j]) <= 2 then
        local ans = menu_panel[i][j]
        if ans == "1" then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          drawCircle(boxX - boxwidth * 0.2, boxY, boxwidth * 0.1, true)
          love.graphics.line(boxX - boxwidth * 0.2, boxY, boxX + boxwidth * 0.2, boxY)
          drawSquare(boxX + boxwidth * 0.2, boxY, boxwidth * 0.2, true)
        end
        if ans == "2" then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          drawSquare(boxX - boxwidth * 0.25, boxY - boxwidth * 0.22, boxwidth * 0.14, true)
          drawCircle(boxX - boxwidth * 0.25, boxY, boxwidth * 0.07, true)
          drawCircle(boxX, boxY, boxwidth * 0.07, true)
          drawPolygon(boxX - boxwidth * 0.25, boxY + boxwidth * 0.25, boxwidth * 0.07, 3, -math.pi / 2, true)
          drawPolygon(boxX, boxY + boxwidth * 0.25, boxwidth * 0.07, 3, -math.pi / 2, true)
          drawPolygon(boxX + boxwidth * 0.25, boxY + boxwidth * 0.25, boxwidth * 0.07, 3, -math.pi / 2, true)
        end
        if ans == "3" and unlocked_symbol[2] == true then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          love.graphics.setLineWidth(linewidth / 2)
          drawSquare(boxX, boxY + boxwidth * 0.2, boxwidth * 0.14, true)
          drawCircle(boxX, boxY - boxwidth * 0.2, boxwidth * 0.08, true)
          love.graphics.setLineWidth(linewidth)
          love.graphics.line(
            boxX - boxwidth * 0.2,
            boxY - boxwidth * 0.4,
            boxX + boxwidth * 0.2,
            boxY - boxwidth * 0.4,
            boxX + boxwidth * 0.2,
            boxY,
            boxX - boxwidth * 0.2,
            boxY,
            boxX - boxwidth * 0.2,
            boxY + boxwidth * 0.4,
            boxX + boxwidth * 0.2,
            boxY + boxwidth * 0.4
          )
        end
        if ans == "4" and (unlocked_symbol[3] == true or unlocked_symbol[4] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          love.graphics.setLineWidth(linewidth / 2)
          drawSquare(boxX - boxwidth * 0.2, boxY - boxwidth * 0.2, boxwidth * 0.15, true)
          drawSquare(boxX - boxwidth * 0.2, boxY - boxwidth * 0.05, boxwidth * 0.15, true)
          drawSquare(boxX - boxwidth * 0.05, boxY - boxwidth * 0.2, boxwidth * 0.15, true)
          drawSquare(boxX + boxwidth * 0.05, boxY + boxwidth * 0.05, boxwidth * 0.15, true)
          drawSquare(boxX + boxwidth * 0.2, boxY + boxwidth * 0.05, boxwidth * 0.15, true)
          drawSquare(boxX + boxwidth * 0.05, boxY + boxwidth * 0.2, boxwidth * 0.15, true)
          --drawSquare(boxX+boxwidth*0.15,boxY+boxwidth*0.15,boxwidth*0.15,true)
          --drawSquare(boxX+boxwidth*0.15,boxY+boxwidth*0.15,boxwidth*0.15,true)
          --drawSquare(boxX+boxwidth*0.15,boxY+boxwidth*0.15,boxwidth*0.15,true)
        end
        if ans == "5" and (unlocked_symbol[3] == true or unlocked_symbol[5] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          drawTetris(boxX, boxY, boxwidth * 0.35, alphabet[5], true)
        end
        if ans == "6" and (unlocked_symbol[4] == true or unlocked_symbol[6] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          love.graphics.line(
            boxX - boxwidth * 0.36,
            boxY + boxwidth * 0.12,
            boxX - boxwidth * 0.12,
            boxY + boxwidth * 0.12,
            boxX - boxwidth * 0.12,
            boxY - boxwidth * 0.12,
            boxX + boxwidth * 0.12,
            boxY - boxwidth * 0.12,
            boxX + boxwidth * 0.12,
            boxY + boxwidth * 0.12,
            boxX + boxwidth * 0.36,
            boxY + boxwidth * 0.12
          )
        end
        if ans == "7" and (unlocked_symbol[5] == true or unlocked_symbol[7] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          drawPolygon(boxX, boxY - boxwidth * 0.3, boxwidth * 0.12, 3, -math.pi / 2, true)
          drawPolygon(boxX, boxY + boxwidth * 0.3, boxwidth * 0.12, 3, math.pi / 2, true)
          drawPolygon(boxX + boxwidth * 0.3, boxY, boxwidth * 0.12, 3, 0, true)
          drawPolygon(boxX - boxwidth * 0.3, boxY, boxwidth * 0.12, 3, math.pi, true)
        end
        if ans == "8" and (unlocked_symbol[6] == true or unlocked_symbol[8] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          local tt = {
            "11",
            "11",
          }
          drawTetris2(boxX, boxY, boxwidth * 0.5, tt, false)
        end
        if ans == "9" and (unlocked_symbol[7] == true or unlocked_symbol[9] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          love.graphics.line(
            boxX - boxwidth * 0.25,
            boxY - boxwidth * 0.15,
            boxX + boxwidth * 0.15,
            boxY - boxwidth * 0.15,
            boxX + boxwidth * 0.15,
            boxY + boxwidth * 0.25
          )
          drawStar(boxX + boxwidth * 0.15, boxY - boxwidth * 0.15, boxwidth * 0.2, 0.5, 5, -math.pi / 10, true)
        end
        if ans == "10" and (unlocked_symbol[8] == true or unlocked_symbol[9] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          for p = -1, 1 do
            for q = -1, 1 do
              love.graphics.setColor(frontcolors[p + 5 + q * 3])
              drawCircle(boxX + p * boxwidth / 4, boxY + q * boxwidth / 4, boxwidth / 16, true)
            end
          end
          --          love.graphics.setColor(frontcolors[tonumber(ans)])
          --          love.graphics.setFont(font2)
          --          love.graphics.printf("?", boxX-500, boxY-font2:getHeight()*0.35, 1000, "center")
        end
        if ans == "11" and (unlocked_symbol[7] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
        end
        if ans == "12" and (unlocked_symbol[8] == true) and not isDemo then
          love.graphics.setColor(midcolors[tonumber(ans)])
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          love.graphics.setColor(frontcolors[tonumber(ans)])
          drawSmallLine(boxX, boxY, boxwidth, "RUR", false)
        end
      elseif menu_panel[i][j] ~= "XXX" then
        love.graphics.setColor(getMidColor(menu_panel[i][j]))
        --      local ans=string.match(menu_panel[i][j],"-%d+")
        --      if ans=="-1" then
        --        drawSquare(boxX,boxY,boxwidth-linewidth+1,true)
        --      end
        if (puzzle_reveal[i][j] ~= 0) or (AllIsVisible == true) then
          drawSquare(boxX, boxY, boxwidth - linewidth + 1, true)
          frontcolor = getBackColor(menu_panel[i][j])
          love.graphics.setColor(frontcolor)
          drawSquare(boxX, boxY, boxwidth * 0.7, true)
          frontcolor = getFrontColor(menu_panel[i][j])
          love.graphics.setColor(frontcolor)
          drawSquare(boxX, boxY, boxwidth * 0.7, false)
          if puzzle_reveal[i][j] == 2 then
            drawTick(boxX + 0.1 * boxwidth, boxY + 0.06 * boxwidth, boxwidth * 0.25)
          end
          drawText(boxX, boxY, menu_panel[i][j])
        end
      end
    end
  end

  boxX = mapleft + select.x * boxwidth
  boxY = maptop + select.y * boxwidth
  love.graphics.setColor(0, 0, 0)
  drawSquare(boxX, boxY, boxwidth, false)

  frontcolor = getFrontColor("END")
  love.graphics.setColor(frontcolor)

  line2 = math.min(screenWidth / 120, screenHeight / 80) / 3 * 2
  if line2 < 1 then
    line2 = 1
  end
  love.graphics.setLineWidth(line2)

  drawUI()
  if isDebug then
    drawTextLeft(100, 100, drawDebugText)
  end
  firstFrame = true
end

function menu.update() end

function menu.keypressed(key, scancode, isrepeat) end

function menu.mousepressed(x, y, button)
  if firstFrame ~= true then
    return
  end
  if button == 1 then
    xx = math.floor((x - mapleft) / boxwidth + 0.5)
    yy = math.floor((y - maptop) / boxwidth + 0.5)
    if (xx > 0) and (yy > 0) and (xx <= mapWidth) and (yy <= mapHeight) then
      if (menu_panel[xx][yy] ~= "XXX") and (len(menu_panel[xx][yy]) > 2) then
        if menu_panel[xx][yy] == "Sound" then
          mute = not mute
          if not mute then
            stopsound()
            src5:play()
          end
          save()
        elseif puzzle_reveal[xx][yy] >= 1 then
          select = { x = xx, y = yy }
          currentLevel = menu_panel[xx][yy]
          level.loadlevel()
        end
      end
    -- top right button (toggle mute, toggle fullscreen , quit game)
    elseif (x > screenWidth - uiSize * 1.2) and (y <= uiSize * 1.2) then
      if love.timer.getTime() - lastclick_time > 0.25 then
        love.event.push("quit")
      end
    elseif (x > screenWidth - uiSize * 2.2) and (y <= uiSize * 1.2) then
      isfullscreen = not isfullscreen
      love.window.setFullscreen(isfullscreen, "desktop")
      save()
    elseif (x > screenWidth - uiSize * 3.2) and (y <= uiSize * 1.2) then
      if mute <= 0 then
        mute = 2
      else
        mute = mute - 1
      end
      if mute ~= 2 then
        stopsound()
        src5:play()
      end
      save()
    end
  end
end

function menu.level_solve(str)
  mapWidth = len(menu_panel)
  mapHeight = len(menu_panel[1])
  for i = 1, mapWidth do
    for j = 1, mapHeight do
      if menu_panel[i][j] == str then
        puzzle_reveal[i][j] = 2
        local ans2 = string.match(menu_panel[i][j], "%d+")
        if tonumber(ans2) ~= nil then
          unlocked_symbol[tonumber(ans2)] = true
        end
        reveal_level(i, j - 1, str)
        reveal_level(i, j + 1, str)
        reveal_level(i - 1, j, str)
        reveal_level(i + 1, j, str)
      end
    end
  end
  solve_cnt = {}
  for i = 1, 12 do
    solve_cnt[i] = 0
  end
  solve_tot = 0
  for i = 1, mapWidth do
    for j = 1, mapHeight do
      if menu_panel[i][j] == "END" then
        if puzzle_reveal[i][j] == 2 then
          solve_tot = solve_tot + 1
        end
      else
        if menu_panel[i][j] ~= "XXX" and len(menu_panel[i][j]) > 2 and menu_panel[i][j] ~= "Sound" then
          if puzzle_reveal[i][j] == 2 then
            solve_tot = solve_tot + 1
            local ans = string.match(menu_panel[i][j], "%d+")
            solve_cnt[tonumber(ans)] = solve_cnt[tonumber(ans)] + 1
          end
        end
      end
    end
  end
end

function reveal_level(w, h, str)
  if (h <= 0) or (w <= 0) or (h > mapHeight) or (w > mapWidth) then
    return
  end
  if menu_panel[w][h] == "XXX" or menu_panel[w][h] == "Sound" or len(menu_panel[w][h]) <= 2 then
    return
  end
  local ans2 = string.match(str, "%d+")
  if tonumber(ans2) == nil then
    return
  end
  if puzzle_reveal[w][h] == 0 then
    if menu_panel[w][h] == "END" then
      puzzle_reveal[w][h] = 1
    else
      local ans = string.match(menu_panel[w][h], "%d+")
      if tonumber(ans) == nil or tonumber(ans2) > tonumber(ans) then
        return
      end
      puzzle_reveal[w][h] = 1
      unlocked_world[tonumber(ans)] = true
    end
  end
  --  if(get(menu_panel[w][h],1)=="#")then
  --    reveal_level(w,h-1,str)
  --    reveal_level(w,h+1,str)
  --    reveal_level(w-1,h,str)
  --    reveal_level(w+1,h,str)
  --  end
end

function menu.load()
  unlocked_world = {}
  unlocked_symbol = {}
  menu_panel = ReadCSV("map.csv")
  mapWidth = len(menu_panel[1])
  mapHeight = len(menu_panel)
  gamestate = "menu"
  local tmp = {}
  for i = 1, mapWidth do
    tmp[i] = {}
    for j = 1, mapHeight do
      tmp[i][j] = menu_panel[j][i]
    end
  end
  menu_panel = tmp

  for i = 1, mapWidth do
    if puzzle_reveal[i] == nil then
      puzzle_reveal[i] = {}
    end
    for j = 1, mapHeight do
      if puzzle_reveal[i][j] == nil then
        puzzle_reveal[i][j] = 0
      end

      if (menu_panel[i][j] ~= "XXX") and (menu_panel[i][j] ~= "Sound") then
        if AllIsVisible then
          if puzzle_reveal[i][j] ~= 2 then
            puzzle_reveal[i][j] = 1
            if AllIsSolve then
              puzzle_reveal[i][j] = 2
            end
          end
        end
        if
          string.match(menu_panel[i][j], "%d+") ~= nil
          and tonumber(string.match(menu_panel[i][j], "%d+")) >= 4
          and isDemo
        then
          menu_panel[i][j] = "XXX"
        elseif len(menu_panel[i][j]) >= 3 then
          --          required_levels[menu_panel[i][j]]=require("level."..menu_panel[i][j])
          --          print(type(required_levels[menu_panel[i][j]]))
          if menu_panel[i][j] == "1-1" and puzzle_reveal[i][j] ~= 2 then
            puzzle_reveal[i][j] = 1
            if select.x < 0 then
              select.x = i
              select.y = j
            end
          end
        end
      end
      if puzzle_reveal[i][j] >= 1 then
        if menu_panel[i][j] == nil then
          ans = nil
        else
          ans = string.match(menu_panel[i][j], "%d+")
        end
        if ans ~= nil then
          unlocked_world[tonumber(ans)] = true
          if puzzle_reveal[i][j] == 2 then
            unlocked_symbol[tonumber(ans)] = true
          end
        end
      end
    end
  end
  if len(reveal) > 0 then
    for k = 1, len(reveal) do
      for i = 1, mapWidth do
        for j = 1, mapHeight do
          if menu_panel[i][j] == reveal[k] then
            puzzle_reveal[i][j] = 2
            menu.level_solve(menu_panel[i][j])
          end
        end
      end
    end
  end
  if AllIsVisible then
    for i = 1, 12 do
      unlocked_world[i] = true
      unlocked_symbol[i] = true
    end
  end

  solve_cnt = {}
  for i = 1, 12 do
    solve_cnt[i] = 0
  end
  solve_tot = 0
  for i = 1, mapWidth do
    for j = 1, mapHeight do
      if menu_panel[i][j] == "END" then
        if puzzle_reveal[i][j] == 2 then
          solve_tot = solve_tot + 1
        end
      else
        if menu_panel[i][j] ~= "XXX" and len(menu_panel[i][j]) > 2 and menu_panel[i][j] ~= "Sound" then
          if puzzle_reveal[i][j] == 2 then
            solve_tot = solve_tot + 1
            local ans = string.match(menu_panel[i][j], "%d+")
            solve_cnt[tonumber(ans)] = solve_cnt[tonumber(ans)] + 1
          end
        end
      end
    end
  end

  print("hello")
  --[[  menu_sprites={}
  menu_sprites["1"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["2"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["3"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["4"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["5"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["6"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["7"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["8"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["9"]=love.graphics.newImage("assets/images/world1.png")
  menu_sprites["10"]=love.graphics.newImage("assets/images/world1.png")
]]
  --[[  local board_total=0
  for i=1,len(menu_panel) do
    for j=1,len(menu_panel[1]) do
      if menu_panel[i][j]~="XXX" and len(menu_panel[i][j])>=3 then
        currentLevel=menu_panel[i][j]
        level.loadlevel()
        print(currentLevel,panel_cnt)
        board_total=board_total+panel_cnt
      end
    end
  end
  print(board_total)]]
end

function menu.re()
  gamestate = "menu"
  mapWidth = len(menu_panel)
  mapHeight = len(menu_panel[1])
  save()
end
