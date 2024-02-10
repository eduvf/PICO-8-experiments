pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
  code = {
    {op = 'set x',    arg = 8   },
    {op = 'set y',    arg = 0   },
    {op = 'set z',    arg = 5   },
    {op = 'repeat',   arg = 8   },
    {op = 'color',    arg = 'x' },
    {op = 'turn',     arg = 'y' },
    {op = 'forward',  arg = 'z' },
    {op = 'add to x', arg = 1   },
    {op = 'add to y', arg = 10  },
    {op = 'add to z', arg = 3   },
    {op = 'print',    arg = 'x' },
    {op = 'end',      arg = ''}
  }
  editor = true
  cursor = {
    line = 1,
    action = 'delete'
  }
  actions = {
    delete = editor_delete
  }
  reset()
end

function _update()
  if btnp(5) then
    editor = not editor
    reset()
    run_code()
  end

  if editor then
    if btnp(2) then
      cursor.line = mid(1, cursor.line - 1, #code)
    end
    if btnp(3) then
      cursor.line = mid(1, cursor.line + 1, #code)
    end
    if btnp(4) then
      actions[cursor.action]()
    end
  end
end

function _draw()
  if editor then
    cls()
    color(1)
    print('editor')
    for i = 1, 18 do
      if code[i] then
        if cursor.line == i then
          print('\f1>\f9'..code[i].op..' \fa'..code[i].arg)
        else
          print(' \fe'..code[i].op..' \ff'..code[i].arg)
        end
      else
        print('')
      end
    end
    color(1)
    print('line: '..cursor.line)
  end
end

function editor_delete()
  deli(code, cursor.line)
end

function reset()
  turtle = {
    x = 64,
    y = 64,
    on = true,
    ang = 0,
    color = 7,
  }
  ip = 1
  var_x = 0
  var_y = 0
  var_z = 0
  cls()
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
