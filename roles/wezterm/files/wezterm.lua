local wezterm = require "wezterm"

local config = wezterm.config_builder and wezterm.config_builder() or {}

config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe" }
config.window_background_opacity = 0
config.win32_system_backdrop = "Mica"
config.window_decorations = "RESIZE"
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback {
  "Cascadia Mono",
  "Cascadia Code",
  "Consolas",
}
config.font_size = 11.6
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false

return config
