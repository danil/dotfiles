function conky_widgets_clock_2()
  if conky_window == nil then return end
  conky_air_clock({format_24 = true, time_zone_modifer = -11})
end
