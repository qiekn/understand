function  distance_total(a,b)
  return math.abs(a.x-b.x)+math.abs(a.y-b.y)
end

function  distance_max(a,b)
  return math.max(math.abs(a.x-b.x),math.abs(a.y-b.y))
end
