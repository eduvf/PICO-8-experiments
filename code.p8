pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  code = {
    {op = 'color',   arg = 8},
    {op = 'turn',    arg = 90},
    {op = 'forward', arg = 40},
    {op = 'turn',    arg = 90},
    {op = 'forward', arg = 30},
    {op = 'turn',    arg = 90},
    {op = 'forward', arg = 20},
    {op = 'turn',    arg = 90},
    {op = 'forward', arg = 10},
  }
  turtle = {
    x = 64,
    y = 64,
    on = true,
    ang = 0,
    color = 7,
  }
  state = 'run'

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
  for ins in all(code) do
    if ins.op == 'color' then
      color(ins.arg)
    elseif ins.op == 'turn' then
      turtle.ang += ins.arg
    elseif ins.op == 'forward' then
      local x, y = turtle.x, turtle.y
      turtle.x -= sin(turtle.ang/360) * ins.arg
      turtle.y -= cos(turtle.ang/360) * ins.arg
      line(x, y, turtle.x, turtle.y)
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
