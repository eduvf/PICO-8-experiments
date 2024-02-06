pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  code = {
    {op = 'set x',   arg = 8},
    {op = 'repeat',  arg = 8},
    {op = 'color',   arg = 'x'},
    {op = 'turn',    arg = 45},
    {op = 'forward', arg = 20},
    {op = 'add to x',arg = 1},
    {op = 'print',   arg = 'x'},
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

  var_x = 0
  var_y = 0
  var_z = 0

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

    if arg == 'x' then arg = var_x end
    if arg == 'y' then arg = var_y end
    if arg == 'z' then arg = var_z end

    if op == 'color' then
      color(arg)
    elseif op == 'print' then
      print(arg)
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
    elseif op == 'set x' then
      var_x = arg
    elseif op == 'set y' then
      var_y = arg
    elseif op == 'set z' then
      var_z = arg
    elseif op == 'add to x' then
      var_x += arg
    elseif op == 'add to y' then
      var_y += arg
    elseif op == 'add to z' then
      var_z += arg
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
