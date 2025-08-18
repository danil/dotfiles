-- <https://github.com/wez/wezterm>.
local wezterm = require 'wezterm'

-- Configuration Files <https://wezfurlong.org/wezterm/config/files.html>.
local config = {}

config.enable_wayland = true
config.audible_bell = "Disabled"
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false -- <https://wezfurlong.org/wezterm/config/lua/config/adjust_window_size_when_changing_font_size.html>.
config.enable_scroll_bar = false
config.hyperlink_rules = wezterm.default_hyperlink_rules()

config.font = wezterm.font_with_fallback {
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
}
config.font_size = 20.0

config.selection_word_boundary = ',│`|:;"\' ()[]{}<>\t·⌑'

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 200
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.animation_fps = 1

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.force_reverse_video_cursor = true -- Overrides the cursor_fg, cursor_bg, cursor_border settings from the color scheme and force the cursor to use reverse video colors based on the foreground and background colors <https://wezfurlong.org/wezterm/config/lua/config/force_reverse_video_cursor.html>.
config.bold_brightens_ansi_colors = "No"

-- Default key bindings <https://wezfurlong.org/wezterm/config/default-keys.html>.
config.disable_default_key_bindings = true
-- config.send_composed_key_when_left_alt_is_pressed = true -- <https://github.com/wez/wezterm/issues/1542>.
-- config.send_composed_key_when_right_alt_is_pressed = true -- <https://github.com/wez/wezterm/issues/1542>.
config.keys = {
  { key = 'Insert', mods = 'CTRL', action = wezterm.action.CopyTo 'Clipboard' },
  { key = 'Insert', mods = 'SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
  { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
  { key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
  { key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
  { key = 'f', mods = 'CMD', action = wezterm.action.ToggleFullScreen },
}

local theme = require 'wezterm_theme'
config.window_frame = theme.window_frame
config.colors       = theme.colors

return config
