pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  colors = { [0]=5, 10, 12, 11, 9, 8, 14, 15, 7, 6, 13, 2 }

  game = {
    { 0, 0, 0, 0 },
    { 0, 0, 0, 0 },
    { 0, 0, 0, 0 },
    { 0, 0, 0, 0 }
  }
end

function put_rnd_num()
  for count = 1, 16 do
    local x = flr(rnd(4)) + 1
    local y = flr(rnd(4)) + 1
    if game[y][x] == 0 then
      game[y][x] = rnd({2, 4})
      break
    end
  end
end

function arrange(x, y, ns)
  if game[y][x] > 0 then
    if #ns == 0 then
      ns[1] = game[y][x]
    else
      if ns[#ns] == game[y][x] then
        ns[#ns] *= 2
      else
        ns[#ns + 1] = game[y][x]
      end
    end
  end
end

function slide(dir)
  if dir == 0 then
    for y = 1, 4 do
      local ns = {}
      
      for x = 1, 4 do
        arrange(x, y, ns)
      end

      for x = 1, 4 do
        if x <= #ns then
          game[y][x] = ns[x]
        else
          game[y][x] = 0
        end
      end
    end
  end
end

function _update()
  local b = btnp()
  local dir = -1
  if (b & 0b0001) > 0 then dir = 0 end -- left
  if (b & 0b0010) > 0 then dir = 1 end -- right
  if (b & 0b0100) > 0 then dir = 2 end -- up
  if (b & 0b1000) > 0 then dir = 3 end -- down

  if dir >= 0 then
    slide(dir)
    put_rnd_num()
  end
end

function _draw()
  cls()
  for y = 1, 4 do
    for x = 1, 4 do
      local n = game[y][x]
      print(n, 32*(x-1), 32*(y-1), colors[n/2])
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
