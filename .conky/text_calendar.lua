--[[

Origin:
~kit-oz Nikita
<http://kit-oz.deviantart.com/art/150px-Conky-203132261>

Modified:
Danil <danil@kutkevich.org>

Description:
Script displays a calendar for given month

To use this script in Conky
1. load scripts:
    lua_load /path/to/text_calendar.lua
2. call function:
    ${lua_parse text_calendar}

Syntax
${lua_parse text_calendar (month)}

Month given relative to the current:
1 next month
-1 previous month
Leave blank for current month
]]

function conky_text_calendar(arg)
  local day_per_month = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
  local wdays = {'mo', 'tu', 'we', 'th', 'fr', '${color1}sa', '${color1}su'}
  --    local wdays = {'пн', 'вт', 'ср', 'чт', 'пт', '${color1}сб', '${color1}вс${color}'}
  local dtable = os.date("*t")
  local year = dtable.year
  local month = dtable.month
  local day = dtable.day

  local arg = tonumber(arg)
  if arg == nil then arg = 0
  else day = -1
  end

  if month == 2 then
    if (year % 4 == 0) and (year % 100 ~= 0) or (year % 400 == 0) then
      day_per_month[2] = day_per_month[2]+1
    end
  end
  month = month + arg
  month = month - math.floor(month / 12 ) * 12
  year = year + math.floor(month / 12 )

  local sday = fWeekDayByDate(1, month, year)

  local start_pos = ''

  local result = start_pos .. '${color}'
  do
    local wday = sday
    result = result .. '${font Liberation Sans:Regular:size=7}'
    result = result .. 'Mon  Tue  Wed  Thu  Fri  ${color1}Sat  Sun${color}'
    --		result = result .. 'пн вт ср чт пт ${color1}сб вс${color}'
    result = result .. '\n${font DejaVu Sans Mono:Regular:size=10}'
    result = result .. start_pos .. string.rep('   ', wday - 1)
    local week = 1
    for i=1, day_per_month[month] do
      if i<10 then result = result .. ' ' end
      if wday >= 6 then result = result .. '${color1}' end
      if i == day then result = result .. '${color2}' end
      result = result .. i
      if i == day then result = result .. '${color}' end
      wday = wday + 1
      if wday >= 7 then result = result .. '${color}' end
      if wday == 8 then
        result = result .. '\n' .. start_pos
        wday = 1
        week = week + 1
      elseif i < day_per_month[month] then
        result = result .. ' '
      end
    end
    result = result .. string.rep('   ', 8-wday) .. '${color}'
    if week < 6 then result = result .. '\n' end
  end

  return result .. '${color}'

end

--[[ day of the week based on date by ramZport ]]--
function fWeekDayByDate(nDay, nMonth, nYear)
  tWeekDay = {5, 6, 7, 1, 2, 3, 4}
  local nAux=math.floor ((14-nMonth)/12)
  nYear=nYear + 1 - nAux
  nMonth=nMonth+12*nAux-2
  local nIndex = math.fmod(7000+(nDay+nYear+math.floor (nYear/4)-math.floor (nYear/100)+math.floor (nYear/400)+math.floor ((31*nMonth)/12)), 7) + 1
  return tWeekDay[nIndex]
end

