---@type wezterm
local wezterm = require("wezterm")
local M = {}

---check if we're on Linux
---@return boolean
M.is_linux = function()
  return wezterm.target_triple:find("linux") ~= nil
end

---check if we're on macOS
---@return boolean
M.is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

return M