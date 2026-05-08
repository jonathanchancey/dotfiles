local hostname = vim.fn.hostname()

local colorscheme = "catppuccin-mocha"

if hostname == "om3.local" then
  colorscheme = "nord"
end

return {
  {
    "catppuccin/nvim",
    "shaunsingh/nord.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme,
    },
  },
}
