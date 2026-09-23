-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 13
config.color_scheme = 'rose-pine-moon'

config.window_background_opacity = 0.9
config.macos_window_background_blur = 15  -- frosted-glass effect, macOS only

-- Finally, return the configuration to wezterm:
return config
