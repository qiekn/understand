function rPrint(s, l, i)
  l = l or 100
  i = i or ""
  if l < 1 then
    print("ERROR: Item limit reached.")
    return l - 1
  end
  local ts = type(s)
  if ts ~= "table" then
    print(i, ts, s)
    return l - 1
  end
  print(i, ts)
  for k, v in pairs(s) do
    l = rPrint(v, l, i .. "\t[" .. tostring(k) .. "]")
    if l < 0 then
      break
    end
  end
  return l
end

function printTable(t, indent)
  indent = indent or 0
  local prefix = string.rep("  ", indent)
  for k, v in pairs(t) do
    if type(v) == "table" then
      print(prefix .. tostring(k) .. ":")
      printTable(v, indent + 1)
    else
      print(prefix .. tostring(k) .. ": " .. tostring(v))
    end
  end
end
