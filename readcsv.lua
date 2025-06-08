function ReadCSV(fileName)
  local lines=love.filesystem.lines(fileName)
  local ans={}
  local id=0
  for line in lines do
    id=id+1
    ans[id]={}
    local str=line
    num=0
    while string.find(str,",")~=nil do
      i, j =string.find(str, ",")
      num =num + 1
      ans[id][num] = string.sub(str, 1, j-1)
      ans[id][num] = string.gsub(ans[id][num]," ","-");
      if len(ans[id][num])<=2 then
        if tonumber(ans[id][num])==nil then
          ans[id][num]="XXX"
        end
      end
      str = string.sub(str, j+1, len(str))
    end
    num =num + 1
    ans[id][num]=str
    ans[id][num] = string.gsub(ans[id][num]," ","-");
    if len(ans[id][num])<=2 then
      if tonumber(ans[id][num])==nil then
        ans[id][num]="XXX"
      end
    end
  end
  return ans
end
