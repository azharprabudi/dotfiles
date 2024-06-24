---@type wezterm
-- Pull in the wezterm API
local wezterm = require 'wezterm'
local utils = require("utils")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Load the keys binding lua configuration
require("keys").apply(config)

-- Set font family
config.font = wezterm.font_with_fallback({
  "MesloLGS NF",
  "Symbols Nerd Font",
})

-- Set font size
config.font_size = 14.0
config.line_height = 1.2

-- Set tabbar
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- Set scroll bar
config.enable_scroll_bar = true

-- Set term to wezterm will break the nvim titlestring option, see https://github.com/wez/wezterm/issues/2112
config.term = "xterm-256color"

-- Set the configurations that only can be apply for MacOS
config.native_macos_fullscreen_mode = false

-- etc
config.default_cursor_style = "BlinkingBar"

config.window_close_confirmation = "AlwaysPrompt"
config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

-- and finally, return the configuration to wezterm
wezterm.plugin
  .require("https://github.com/catppuccin/wezterm")
  .apply_to_config(config, {
    flavor = "mocha",
    sync = utils.is_darwin(),
    sync_flavors = { light = "frappe", dark = "mocha" },
  })
wezterm.plugin
  .require("https://github.com/nekowinston/wezterm-bar")
  .apply_to_config(config, {
    clock = {
      enabled = false,
    },
  })

return config