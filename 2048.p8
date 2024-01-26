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
      game[y][x] = rnd({1, 2})
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
        ns[#ns] += 1
      else
        ns[#ns + 1] = game[y][x]
      end
    end
  end
end

function horizontal_movement(from, to, step)
  for y = 1, 4 do
    local ns = {}

    for x = from, to, step do
      arrange(x, y, ns)
    end

    for x = from, to, step do
      game[y][x] = deli(ns, 1) or 0
    end
  end
end

function vertical_movement(from, to, step)
  for x = 1, 4 do
    local ns = {}

    for y = from, to, step do
      arrange(x, y, ns)
    end

    for y = from, to, step do
      game[y][x] = deli(ns, 1) or 0
    end
  end
end

function slide(dir)
  if dir == 0 then
    horizontal_movement(1, 4, 1)
  elseif dir == 1 then
    horizontal_movement(4, 1, -1)
  elseif dir == 2 then
    vertical_movement(1, 4, 1)
  elseif dir == 3 then
    vertical_movement(4, 1, -1)
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
      local pr_n = n > 0 and 2^n or 0
      print(pr_n, 32*(x-1), 32*(y-1), colors[n])
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
