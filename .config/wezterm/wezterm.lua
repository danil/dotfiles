-- <https://github.com/wez/wezterm>.
local wezterm = require 'wezterm'

-- Configuration Files <https://wezfurlong.org/wezterm/config/files.html>.
return {
  enable_wayland = false,
  disable_default_key_bindings = true,
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false, -- <https://wezfurlong.org/wezterm/config/lua/config/adjust_window_size_when_changing_font_size.html>.
  enable_scroll_bar = false,
  -- send_composed_key_when_left_alt_is_pressed = true, -- <https://github.com/wez/wezterm/issues/1542>.
  -- send_composed_key_when_right_alt_is_pressed = true, -- <https://github.com/wez/wezterm/issues/1542>.

  font = wezterm.font_with_fallback {
    'PragmataPro Mono Liga',
    'PragmataPro Liga',
    'PragmataPro',
    'Fantasque Sans Mono',
    'Fira Code',
    'Hack',
    'Roboto Mono',
    'Cascadia Code',
    'Share Tech Mono',
    'JetBrains Mono',
    'DejaVu Sans Mono',
  },
  font_size = 48.0,

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
    active_titlebar_bg = '#000000', -- The overall background color of the tab bar when the window is focused.
    inactive_titlebar_bg = '#000000', -- The overall background color of the tab bar when the window is not focused.
  },

  -- force_reverse_video_cursor = true, -- Overrides the cursor_fg, cursor_bg, cursor_border settings from the color scheme and force the cursor to use reverse video colors based on the foreground and background colors <https://wezfurlong.org/wezterm/config/lua/config/force_reverse_video_cursor.html>.

  colors = {
    foreground = '#e5e5e5', -- The default text color.
    background = '#000000', -- The default background color.
    cursor_bg = '#ff0000', -- Overrides the cell background color when the current cell is occupied by the cursor and the cursor style is set to Block.
    cursor_fg = '#ffffff', -- Overrides the text color when the current cell is occupied by the cursor.

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

  -- Default key bindings <https://wezfurlong.org/wezterm/config/default-keys.html>.
  keys = {
    { key = 'Insert', mods = 'CTRL', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'Insert', mods = 'SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
    { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
    { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
    { key = 'f', mods = 'CMD', action = wezterm.action.ToggleFullScreen },
   },
}
