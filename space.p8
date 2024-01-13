pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
ang_vel = 0.02
lin_acc = 0.2
fric = 0.9

anim = {
  {1, false, false},
  {2, true, false},
  {3, true, false},
  {2, true, true},
  {1, false, true},
  {2, false, true},
  {3, false, false},
  {2, false, false},
}

fx = {}
fx_col = {8, 9, 10, 7, 6, 5}

function _init()
  p = {
    x = 64,
    y = 64,
    ang = 0.25,
    vel = 0,
    acc = 0,
    anim = 1,
    frame = 1,
    flipx = false,
    flipy = false
  }
  missiles = {}
end

function add_fx()
  add(fx, {
    x = p.x + 2 + flr(rnd(4)),
    y = p.y + 2 + flr(rnd(4)),
    t = 0,
    life = rnd(50) + 50
  })
end

function update_fx()
  for f in all(fx) do
    f.x += rnd() > 0.95 and rnd({-1, 1}) or 0
    f.y += rnd() > 0.95 and rnd({-1, 1}) or 0
    f.t += 1
    if f.t > f.life then
      del(fx, f)
    end
  end
end

function draw_fx()
  for f in all(fx) do
    local c = fx_col[flr((f.t/f.life) * #fx_col) + 1]
    pset(f.x, f.y, c)
  end
end

function add_missile()
  add(missiles, {
    x = p.x + 4,
    y = p.y + 4,
    ang = p.ang
  })
end

function update_missiles()
  for m in all(missiles) do
    m.x += cos(m.ang) * 3
    m.y += sin(m.ang) * 3

    if 0 > m.x or m.x > 128
    or 0 > m.y or m.y > 128 then
      del(missiles, m)
    end
  end
end

function draw_missiles()
  for m in all(missiles) do
    pset(m.x, m.y, 12)
  end
end

function _update()
  p.acc = 0
  p.vel *= fric
  update_fx()
  update_missiles()

  if btn(0) then p.ang += ang_vel end
  if btn(1) then p.ang -= ang_vel end
  if btn(4) then
    p.acc = lin_acc
    add_fx()
  end
  if btnp(5) then
    add_missile()
  end

  p.ang %= 1

  p.vel += p.acc
  p.x += cos(p.ang) * p.vel
  p.y += sin(p.ang) * p.vel
end

function _draw()
  cls()

  print(p.vel)
  print(#fx)

  p.anim = flr(p.ang * 8 + 6.5) % 8 + 1
  p.frame = anim[p.anim][1]
  p.flipx = anim[p.anim][2]
  p.flipy = anim[p.anim][3]
  
  draw_fx()
  draw_missiles()
  spr(p.frame, p.x, p.y, 1, 1, p.flipx, p.flipy)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000aa0000000aa0000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000aa000009aaa00000aaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000009aa900000aa000000aaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700009009000000900000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
