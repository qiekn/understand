function print_grid(grid)
  for k,v in pairs(grid)do
    local tmp=""
    for i=-10,10 do
      if v[i]==true then
        tmp=tmp.."O"
      elseif v[i]==false then
        tmp=tmp.."X"
      elseif v[i]~=nil then
        tmp=tmp..v[i]
      else
        tmp=tmp.." "
      end
    end
    print(tmp)
  end
end
