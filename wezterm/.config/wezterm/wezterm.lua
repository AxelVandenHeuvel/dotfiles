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

-- Cmd+C copies WezTerm's own selection. Inside tmux the highlight belongs to tmux
-- (it already copied it on mouse release), so WezTerm has no selection and the
-- default Cmd+C would overwrite the clipboard with an empty string. Only copy
-- when WezTerm actually has something selected.
config.keys = {
  {
    key = 'c',
    mods = 'CMD',
    action = wezterm.action_callback(function(window, pane)
      local sel = window:get_selection_text_for_pane(pane)
      if sel ~= '' then
        window:perform_action(wezterm.action.CopyTo 'Clipboard', pane)
      end
    end),
  },
}

-- Finally, return the configuration to wezterm:
return config
