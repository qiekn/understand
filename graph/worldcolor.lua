backcolors = {}
frontcolors = {}
midcolors = {}
--[[
frontcolors[1]={248/255,144/255,32/255}
backcolors[1]={248/255,240/255,136/255}
frontcolors[2]={121/255,189/255,57/255}
backcolors[2]={233/255,241/255,223/255}
frontcolors[3]={249/255,168/255,117/255}
backcolors[3]={255/255,245/255,211/255}
frontcolors[4]={26/255,19/255,35/255}
backcolors[4]={168/255,185/255,234/255}
frontcolors[5]={40/255,40/255,40/255}
backcolors[5]={165/255,165/255,165/255}
frontcolors[6]={34/255,34/255,34/255}
backcolors[6]={240/255,246/255,240/255}
frontcolors[7]={57/255,120/255,168/255}
backcolors[7]={137/255,234/255,240/255}
frontcolors[8]={114/255,40/255,67/255}
backcolors[8]={222/255,144/255,176/255}
frontcolors[9]={213/255,30/255,60/255}
backcolors[9]={255/255,181/255,17/255}
frontcolors[10]={41/255,77/255,92/255}
backcolors[10]={213/255,245/255,254/255}


frontcolors[1]={248/255,144/255,32/255}
backcolors[1]={248/255,240/255,136/255}
frontcolors[2]={121/255,189/255,57/255}
backcolors[2]={233/255,241/255,223/255}
frontcolors[3]={249/255,168/255,117/255}
backcolors[3]={255/255,245/255,211/255}
frontcolors[4]={57/255,120/255,168/255}
backcolors[4]={137/255,234/255,240/255}
frontcolors[5]={110/255,112/255,74/255}
backcolors[5]={34/255,234/255,185/255}
frontcolors[6]={40/255,40/255,40/255}
backcolors[6]={165/255,165/255,165/255}
frontcolors[7]={26/255,19/255,35/255}
backcolors[7]={168/255,185/255,234/255}
frontcolors[8]={114/255,40/255,67/255}
backcolors[8]={222/255,144/255,176/255}
frontcolors[9]={213/255,30/255,60/255}
backcolors[9]={255/255,181/255,147/255}
frontcolors[10]={41/255,77/255,92/255}
backcolors[10]={213/255,245/255,254/255}
frontcolors[11]={34/255,34/255,34/255}
backcolors[11]={240/255,246/255,240/255}]]

frontcolors[1] = { 34 / 255, 159 / 255, 34 / 255 }
frontcolors[9] = { 12 / 255, 12 / 255, 102 / 255 }
frontcolors[8] = { 180 / 255, 27 / 255, 33 / 255 }
frontcolors[11] = { 127 / 255, 127 / 255, 127 / 255 }
frontcolors[12] = { 96 / 255, 56 / 255, 17 / 255 }
--backcolors[12]={1,1,0}
--frontcolors[12]={0,0,0}
frontcolors[7] = { 125 / 255, 0 / 255, 125 / 255 }
frontcolors[3] = { 200 / 255, 110 / 255, 60 / 255 }
frontcolors[5] = { 25 / 255, 25 / 255, 170 / 255 }
--frontcolors[6]={144/255,87/255,30/255}
frontcolors[6] = { 128 / 255, 128 / 255, 0 / 255 }

--frontcolors[9]={41/255,77/255,92/255}
--frontcolors[9]=frontcolors[1]
frontcolors[4] = { 167 / 255, 167 / 255, 0 / 255 }
frontcolors[2] = { 34 / 255, 90 / 255, 34 / 255 }
--frontcolors[12]={34/255,34/255,34/255}

frontcolors[10] = { 0.2, 0.2, 0.2 }
backcolors[10] = { 0.8, 0.8, 0.8 }
midcolors[10] = { 0.5, 0.5, 0.5 }
frontcolors[100] = { 0.8, 0.8, 0.8 }
backcolors[100] = { 0.2, 0.2, 0.2 }
midcolors[100] = { 0.5, 0.5, 0.5 }

frontcolors[101] = { 0.2, 0.2, 0.2 }
backcolors[101] = { 0.8, 0.8, 0.8 }
midcolors[101] = { 0.5, 0.5, 0.5 }

--frontcolors[1]={38/255,32/255,96/255}

for i = 1, len(frontcolors) do
  --  frontcolors[i]=frontcolors[1]
  if backcolors[i] == nil then
    backcolors[i] = {}
    backcolors[i][1] = frontcolors[i][1] * 0.33 + 0.67
    backcolors[i][2] = frontcolors[i][2] * 0.33 + 0.67
    backcolors[i][3] = frontcolors[i][3] * 0.33 + 0.67
  end
  if midcolors[i] == nil then
    midcolors[i] = {}
    midcolors[i][1] = frontcolors[i][1] * 0.25 + backcolors[i][1] * 0.75
    midcolors[i][2] = frontcolors[i][2] * 0.25 + backcolors[i][2] * 0.75
    midcolors[i][3] = frontcolors[i][3] * 0.25 + backcolors[i][3] * 0.75
  end
end

--backcolor_menu={40/255,44/255,52/255}
--backcolor_menu={247/255,238/255,214/255}
backcolor_menu = { 221 / 255, 221 / 255, 221 / 255 }

function getBackColor(level)
  local ans = string.match(level, "%d+")
  if get(level, 1, 2) == "EX" then
    return backcolors[100]
  elseif level == "END" or level == "Sound" then
    return backcolors[101]
  elseif backcolors[tonumber(ans)] == nil then
    return { 0, 0, 0 }
  end
  return backcolors[tonumber(ans)]
end

function getFrontColor(level)
  local ans = string.match(level, "%d+")
  if get(level, 1, 2) == "EX" then
    return frontcolors[100]
  elseif level == "END" or level == "Sound" then
    return frontcolors[101]
  elseif frontcolors[tonumber(ans)] == nil then
    return { 0, 0, 0 }
  end
  return frontcolors[tonumber(ans)]
end

function getMidColor(level)
  local ans = string.match(level, "%d+")
  if get(level, 1, 2) == "EX" then
    return midcolors[100]
  elseif level == "END" or level == "Sound" then
    return midcolors[101]
  elseif midcolors[tonumber(ans)] == nil then
    return { 0, 0, 0 }
  end
  return midcolors[tonumber(ans)]
end
