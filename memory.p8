pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  t = 0
  start = 100
  timer = 0
  timer_colors = {4, 3, 1, 2}
  update = init_game_update
  
  board = {}
  cards = {
    "\f9🐱", "\fc♪", "\fa★", "\fb●",
    "\ff⌂", "\fe⧗", "\f6◆", "\f8♥"
  }
  cursor = { x = 1, y = 1 }
  hide = {}
  seen = {
    first = 0,
    second = 0
  }
  match = false

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
    hide[i] = false
  end
end

function switch_hide_all()
  for i = 1, 16 do
    hide[i] = not hide[i]
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
      bg = "\#1"
    end

    if hide[i] then
      print(bg.."\f2ˇ", x, y)
    else
      print(bg..board[i], x, y)
    end
  end
end

function check_match()
  return board[seen.first] == board[seen.second]
end

function init_game_update()
  timer = t / start
  if t >= start then
    update = main_game_update
    switch_hide_all()
  end
end

function main_game_update()
  if btnp(0) then cursor.x = mid(1, (cursor.x-1), 4) end
  if btnp(1) then cursor.x = mid(1, (cursor.x+1), 4) end
  if btnp(2) then cursor.y = mid(1, (cursor.y-1), 4) end
  if btnp(3) then cursor.y = mid(1, (cursor.y+1), 4) end

  if btnp(4) then
    local i = cursor.x + (cursor.y-1)*4
    hide[i] = not hide[i]
    if seen.first == 0 then
      seen.first = i
    elseif seen.second == 0 then
      seen.second = i
      match = check_match()
      if match then
        match = false
      else
        hide[seen.first] = true
        hide[seen.second] = true
      end
      seen.first, seen.second = 0, 0
    end
  end
end

function _update()
  t += 1

  update()
end

function _draw()
  cls()
  local timer_col = ceil(timer * #timer_colors)
  rectfill(0, 0, timer * 128, 0, timer_colors[timer_col])

  print_board()
  -- print(cursor.x..cursor.y)
  print(seen.first.." "..seen.second)
  print((board[seen.first]or"").." "..(board[seen.second]or""))
  print(match)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
