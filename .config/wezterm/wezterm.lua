-- <https://github.com/wez/wezterm>.
local wezterm = require 'wezterm'

return {
  enable_wayland = false,
  disable_default_key_bindings = true,

  -- <https://wezfurlong.org/wezterm/config/lua/config/adjust_window_size_when_changing_font_size.html>.
  adjust_window_size_when_changing_font_size = false,

  font = wezterm.font {
    family = 'PragmataPro Liga',
  },

  font_size = 48.0,
  enable_scroll_bar = false,

  default_cursor_style = 'BlinkingBlock',
  cursor_blink_ease_in = "Constant",
  cursor_blink_rate = 150,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  window_frame = {
    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = '#000000',
    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#000000',
  },

  colors = {
    -- The default text color
    foreground = '#e5e5e5',
    -- The default background color
    background = '#000000',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#ff0000',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#ffffff',

    ansi = {
      '#000000',
      '#cd0000',
      '#00cd00',
      '#cdcd00',
      '#2222ee',
      '#cd00cd',
      '#00cdcd',
      '#e5e5e5',
    },
    brights = {
      '#7f7f7f',
      '#ff0000',
      '#00ff00',
      '#ffff00',
      '#5c5cff',
      '#ff00ff',
      '#00ffff',
      '#ffffff',
    },
  },

  keys = {
    { key = '-', mods = 'CMD', action = wezterm.action.Multiple { wezterm.action.DecreaseFontSize, wezterm.action.ReloadConfiguration } },
    { key = '=', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
    { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },
    { key = 'f', mods = 'CMD', action = wezterm.action.ToggleFullScreen },
   },
}
