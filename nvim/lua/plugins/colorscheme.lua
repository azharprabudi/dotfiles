return {
  "catppuccin/nvim",
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme("catppuccin-macchiato")
  end,
}