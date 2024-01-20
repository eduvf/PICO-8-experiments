pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
prev = {}
next = {}

function _init()
  for p = 0, 16384-1 do
    prev[p] = rnd() > 0.9
  end
end

function _update()
  for p = 0, 16384-1 do
    local alive = 0

    if prev[(p-128-1)%16384] then alive += 1 end
    if prev[(p-128)  %16384] then alive += 1 end
    if prev[(p-128+1)%16384] then alive += 1 end
    if prev[(p-1)    %16384] then alive += 1 end
    if prev[(p+1)    %16384] then alive += 1 end
    if prev[(p+128-1)%16384] then alive += 1 end
    if prev[(p+128)  %16384] then alive += 1 end
    if prev[(p+128+1)%16384] then alive += 1 end

    if prev[p] then
      next[p] = (alive == 2) or (alive == 3)
    else
      next[p] = alive == 3
    end
  end

  for p = 0, 16384-1 do
    prev[p] = next[p]
  end
end

function _draw()
  cls()

  for p = 0, 16384-1 do
    if prev[p] then
      pset(p%128, flr(p/128), 1)
    end
  end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
