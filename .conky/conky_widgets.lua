--[[
conky_window:

visual userdata: 0x2386478
text_start_y: 1
border_inner_margin: 0
width: 2
border_width :1
text_height: 849
drawable userdata: 0x2386438
text_start_x: 1
height: 2
text_width: 160
border_outer_margin: 0
displayuserdata: 0x2386578
visualuserdata: 0x2386478
text_start_y: 1
border_inner_margin: 0
width: 162
border_width: 1
text_height: 849
drawable: userdata: 0x2386438
text_start_x: 1
height851
text_width: 160
border_outer_margin: 0
displayuserdata: 0x2386578
]]

function conky_widgets()
  if conky_window == nil then return end
  conky_draw_clock()
  conky_clock_rings()
end