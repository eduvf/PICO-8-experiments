pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  t = 0
  
  board = {}
  cards = {
    "\f9🐱", "\fc♪", "\fa★", "\fb●",
    "\ff⌂", "\fe⧗", "\f6◆", "\f8♥"
  }
  cursor = { x = 1, y = 1 }

  generate_board()
end

function generate_board()
  for i = 1, 16 do
    local c = ceil(i/16*8)
    while true do
      local r = flr(rnd(16)) + 1
      if board[r] == nil then
        board[r] = cards[c]
        break
      end
    end
  end
end

function print_board()
  local offset = 8
  local spacing = 12
  local cursor_index = cursor.x + (cursor.y-1)*4

  for i = 1, 16 do
    local x = (i-1) % 4 * spacing + offset
    local y = flr((i-1) / 4) * spacing + offset
    local bg = ""
    if i == cursor_index then
      bg = "\#2"
    end
    print(bg..board[i], x, y)
  end
end

function _update()
  t += 1

  if btnp(0) then cursor.x = mid(1, (cursor.x-1), 4) end
  if btnp(1) then cursor.x = mid(1, (cursor.x+1), 4) end
  if btnp(2) then cursor.y = mid(1, (cursor.y-1), 4) end
  if btnp(3) then cursor.y = mid(1, (cursor.y+1), 4) end
end

function _draw()
  cls()
  print_board()
  -- print(cursor.x..cursor.y)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
