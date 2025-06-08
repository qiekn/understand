function drawUI()
  if gamestate == "menu" then
    drawCross(
      screenWidth - uiSize * 0.7,
      uiSize * 0.7,
      uiSize * 0.4,
      uiSize * 0.15,
      math.pi / 4,
      solve_tot >= level_num
    )
  else
    drawCross(screenWidth - uiSize * 0.7, uiSize * 0.7, uiSize * 0.4, uiSize * 0.15, math.pi / 4, AllVictory())
  end
  --  drawSprite(0,0,100,sound_sprite)
  drawSquare(screenWidth - uiSize * 1.7, uiSize * 0.7, uiSize * 0.8, false)
  if isfullscreen then
  --    drawSprite(screenWidth-uiSize*1.7,uiSize*0.7,uiSize*0.5,fullscreen_sprite2)
  else
    local x4 = screenWidth - uiSize * 1.7
    local y4 = uiSize * 0.7
    local d4 = uiSize * 0.4
    love.graphics.line(x4 - d4, y4 - 0.3 * d4, x4 + 0.3 * d4, y4 - 0.3 * d4, x4 + 0.3 * d4, y4 + d4)
  end

  local x4 = screenWidth - uiSize * 2.7
  local y4 = uiSize * 0.7
  local d4 = uiSize * 0.4

  local pts =
    { x4 - d4 * 0.5, y4 + d4 * 0.5, x4 - d4 * 0.5, y4 - d4 * 0.5, x4 + d4 * 0.5, y4 - d4, x4 + d4 * 0.5, y4 + d4 }
  love.graphics.polygon("line", pts)
  if mute == 0 then
    love.graphics.polygon("fill", pts)
  end
  if mute == 2 then
    love.graphics.line(
      screenWidth - uiSize * 2.7 - uiSize * 0.4,
      uiSize * 0.7 - uiSize * 0.4,
      screenWidth - uiSize * 2.7 + uiSize * 0.4,
      uiSize * 0.7 + uiSize * 0.4
    )
  end
end
