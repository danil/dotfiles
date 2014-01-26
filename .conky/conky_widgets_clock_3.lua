function conky_widgets_clock_3()
  if conky_window == nil then return end
  conky_air_clock({format_24 = true, time_zone_modifer = -11}) --relative to moscow (local time)
end
