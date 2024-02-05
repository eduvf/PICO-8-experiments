pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  code = {
    {op = 'color',   arg = 8},
    {op = 'repeat',  arg = 4},
    {op = 'turn',    arg = 90},
    {op = 'forward', arg = 40},
    {op = 'end'}
  }
  turtle = {
    x = 64,
    y = 64,
    on = true,
    ang = 0,
    color = 7,
  }
  state = 'run'
  ip = 1

  cls()
  run_code()
end

function _update()
  -- if btnp(0) then
  --   fn = mid(1, fn - 1, #fn_list)
  -- elseif btnp(1) then
  --   fn = mid(1, fn + 1, #fn_list)
  -- end

  -- if btnp(4) then
  --   add(code, fn_list[fn])
  -- end
end

function _draw()
  -- cls()
  -- local hud = "\fd⬅️ \fc"..fn_list[fn].." \fd➡️"
  -- print(hud, 64 - (#hud/2)*3, 0)

  -- cursor(0, 12, 2)
  -- for i = 1, #code do
  --   print(code[i])
  -- end
end

function run_code()
  while ip <= #code do
    local op = code[ip].op
    local arg = code[ip].arg

    if op == 'color' then
      color(arg)
    elseif op == 'up' then
      turtle.on = false
    elseif op == 'down' then
      turtle.on = true
    elseif op == 'turn' then
      turtle.ang += arg
    elseif op == 'forward' then
      local x, y = turtle.x, turtle.y
      turtle.x -= sin(turtle.ang/360) * arg
      turtle.y -= cos(turtle.ang/360) * arg
      if turtle.on then
        line(x, y, turtle.x, turtle.y)
      end
    elseif op == 'repeat' then
      local curr_ip = ip + 1
      for _ = 1, arg do
        ip = curr_ip
        run_code()
      end
    elseif op == 'end' then
      return
    end

    ip += 1
  end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
