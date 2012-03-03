--[[
Origin:
Air Clock by Alison Pitt (2009)
<http://londonali1010.deviantart.com/art/quot-Air-quot-Clock-for-Conky-141958642>

Modified:
Danil <danil@kutkevich.org>

Description:
This clock is designed to look like KDE 4.3's "Air" clock, but from inside Conky.

You can adjust the clock's radius and placement, as well as the size and offset of the drop shadow. You can also choose whether to display the seconds hand. This clock updates every time Conky does, so if you want to show seconds, it is recommended that you set update_interval to no more than 0.5s. If you turn off seconds, you can set the update_interval to as long as 30s.  The settings are in the "Settings" section, starting at Line 21.

Call this script in Conky using the following before TEXT (assuming you save this script to ~/scripts/clock.lua):
    lua_load ~/scripts/clock.lua
    lua_draw_hook_pre draw_clock
]]

require 'cairo'
function conky_air_clock()
  if conky_window == nil then return end
  local w = conky_window.width
  local h = conky_window.height
  local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, w, h)
  cr = cairo_create(cs)

  -- Settings

  -- What radius should the clock face (not including border) be, in pixels?

  local clock_r = 60

  -- x and y coordinates, relative to the top left corner of Conky, in pixels

  local xc = w - (clock_r * 1.25) - 10
  local yc = clock_r * 1.25

  -- Extent of the shadow, in pixels

  shadow_width = 5

  -- x and y offsets of the drop shadow, relative to the centre of the clock face, in pixels. Can be positive (downward) or negative (upward)

  shadow_xoffset = 0
  shadow_yoffset = 2

  -- Do you want to show the second hand? Use this if you use a Conky update_interval > 1s. Can be true or false.

  show_seconds = false

  -- Grab time

  local hours = os.date("%I")
  local mins = os.date("%M")
  local secs = os.date("%S")

  secs_arc = (2 * math.pi / 60) * secs
  mins_arc = (2 * math.pi / 60) * mins
  hours_arc = (2 * math.pi / 12) * hours + mins_arc / 12

  -- Drop shadow

  local ds_pat = cairo_pattern_create_radial(xc + shadow_xoffset, yc + shadow_yoffset, clock_r * 1.25, xc + shadow_xoffset, yc + shadow_yoffset, clock_r * 1.25 + shadow_width)
  cairo_pattern_add_color_stop_rgba(ds_pat, 0, 0, 0, 0, 0.2)
  cairo_pattern_add_color_stop_rgba(ds_pat, 1, 0, 0, 0, 0)

  cairo_move_to(cr, 0, 0)
  cairo_line_to(cr, w, 0)
  cairo_line_to(cr, w, h)
  cairo_line_to(cr, 0, h)
  cairo_new_sub_path(cr)
  cairo_arc(cr, xc, yc, clock_r * 1.25, 0, 2 * math.pi)
  cairo_set_source(cr, ds_pat)
  cairo_set_fill_rule(cr, CAIRO_FILL_RULE_EVEN_ODD)
  cairo_fill(cr)

  -- Glassy border

  cairo_arc(cr, xc, yc, clock_r * 1.25, 0, 2 * math.pi)
  cairo_set_source_rgba(cr, 0.5, 0.5, 0.5, 0.2)
  cairo_set_line_width(cr, 1)
  cairo_stroke(cr)

  local border_pat = cairo_pattern_create_linear(xc, yc - clock_r * 1.25, xc, yc + clock_r * 1.25)

  cairo_pattern_add_color_stop_rgba(border_pat, 0, 1, 1, 1, 0.7)
  cairo_pattern_add_color_stop_rgba(border_pat, 0.3, 1, 1, 1, 0)
  cairo_pattern_add_color_stop_rgba(border_pat, 0.5, 1, 1, 1, 0)
  cairo_pattern_add_color_stop_rgba(border_pat, 0.7, 1, 1, 1, 0)
  cairo_pattern_add_color_stop_rgba(border_pat, 1, 1, 1, 1, 0.7)
  cairo_set_source(cr, border_pat)
  cairo_arc(cr, xc, yc, clock_r * 1.125, 0, 2 * math.pi)
  cairo_close_path(cr)
  cairo_set_line_width(cr, clock_r * 0.25)
  cairo_stroke(cr)

  -- Set clock face

  cairo_arc(cr, xc, yc, clock_r, 0, 2 * math.pi)
  cairo_close_path(cr)

  local face_pat = cairo_pattern_create_radial(xc, yc - clock_r * 0.75, 0, xc, yc, clock_r)

  cairo_pattern_add_color_stop_rgba(face_pat, 0, 1, 1, 1, 0.9)
  cairo_pattern_add_color_stop_rgba(face_pat, 0.5, 1, 1, 1, 0.9)
  cairo_pattern_add_color_stop_rgba(face_pat, 1, 0.9, 0.9, 0.9, 0.9)
  cairo_set_source(cr, face_pat)
  cairo_fill_preserve(cr)
  cairo_set_source_rgba(cr, 0.5, 0.5, 0.5, 0.2)
  cairo_set_line_width(cr, 1)
  cairo_stroke (cr)

  -- Draw hours numbers <http://forum.learnfree.eu/viewtopic.php?f=9&t=422&start=105#p8436>.
  do
    t = {
      radius = clock_r,
      x = xc,
      y = yc,
      font_name = "DejaVu Sans",
      font_size = 14,
      bold = true,
      italic = false,
      color = 0x000000,
      alpha = 0.5
    }

    local slant = CAIRO_FONT_SLANT_NORMAL
    local weight =CAIRO_FONT_WEIGHT_NORMAL
    if t.italic then slant = CAIRO_FONT_SLANT_ITALIC end
    if t.bold then weight = CAIRO_FONT_WEIGHT_BOLD end

    -- Save state.
    cairo_save (cr)

    -- добавляем часовые деления
    -- зададим цвет
    cairo_set_source_rgba(cr, rgb_to_r_g_b(t.color, t.alpha))
    -- сбрасываем счетчик делений на 0
    local i = 0
    -- задаем расстояние между делениями
    local winkel = math.rad(30)
    -- выводим 12 делений
    for i= 0, 11, 1 do
      cairo_move_to(cr, t.x - math.sin(winkel*i)*t.radius, t.y - math.cos(winkel*i)*t.radius)
      -- длину делений берем равной 0.1 от длины радиуса
      cairo_line_to(cr, t.x - math.sin(winkel*i)*(t.radius*0.95), t.y - math.cos(winkel*i)*(t.radius*0.95))

      -- выводим изображение
      cairo_stroke (cr)
    end

    -- добавляем минутные деления
    -- сбрасываем счетчик делений на 0
    local i = 0
    -- задаем расстояние между делениями
    local winkel = math.rad(6)
    -- выводим 12 делений
    for i=0, 59, 1 do
      cairo_move_to(cr, t.x - math.sin(winkel * i) * t.radius, t.y - math.cos(winkel * i) * t.radius)
      -- длину делений берем равной 0.1 от длины радиуса
      cairo_line_to(cr, t.x - math.sin(winkel * i) * (t.radius * 0.98), t.y - math.cos(winkel * i) * (t.radius*0.98))
    end
    -- выводим изображение
    cairo_stroke (cr)

    cairo_set_source_rgba(cr, 0.5, 0.5, 0.5, 0.9)
    cairo_select_font_face(cr, t.font_name, slant, weight)
    cairo_set_font_size(cr, t.font_size)
    te=cairo_text_extents_t:create()
    cairo_text_extents(cr,t.text,te)

    -- переносим значения координат
    cairo_translate(cr, t.x, t.y)
    -- сбрасываем координаты цифр
    local mx = 0
    local my = 0
    -- сбрасываем счетчик делений на 0
    local i = 0
    -- задаем расстояние между цифрами
    local winkel = math.rad(30)
    -- необходимо вывести цифра начиная с 1 и заканчивая 12
    for i = 1, 12, 1 do
      -- расчитываем координаты цифр
      mov_x = math.sin(winkel*i)*(t.radius*0.78)
      mov_y = math.cos(winkel*i)*(t.radius*0.78)
      -- расчитываем ширину и высоту цифр
      te=cairo_text_extents_t:create()
      cairo_text_extents (cr,i,te)
      -- вносим поправку на половину ширины и половину высоты цифр
      mx = -te.width/2
      my = -te.height/2-te.y_bearing
      -- задаем координаты цифр
      cairo_move_to(cr, mx + mov_x, my - mov_y)
      -- выводим цифры
      cairo_show_text(cr, i)
    end

    -- Restore state.
    cairo_restore (cr)
  end

  -- Draw hour hand

  xh = xc + 0.62 * clock_r * math.sin(hours_arc)
  yh = yc - 0.62 * clock_r * math.cos(hours_arc)
  cairo_move_to(cr, xc, yc)
  cairo_line_to(cr, xh, yh)

  cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)
  cairo_set_line_width(cr, 5)
  cairo_set_source_rgba(cr, 0, 0, 0, 0.5)
  cairo_stroke(cr)


  -- Draw minute hand

  xm = xc + 0.84 * clock_r * math.sin(mins_arc)
  ym = yc - 0.84 * clock_r * math.cos(mins_arc)
  cairo_move_to(cr, xc, yc)
  cairo_line_to(cr, xm, ym)

  cairo_set_line_width(cr, 3)
  cairo_stroke(cr)

  -- Draw seconds hand

  if show_seconds then
    xs = xc + 0.9 * clock_r * math.sin(secs_arc)
    ys = yc - 0.9 * clock_r * math.cos(secs_arc)
    cairo_move_to(cr, xc, yc)
    cairo_line_to(cr, xs, ys)

    cairo_set_line_width(cr, 1)
    cairo_stroke(cr)
  end
end
