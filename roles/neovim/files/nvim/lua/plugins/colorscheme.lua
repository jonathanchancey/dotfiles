local hostname = vim.fn.hostname()

local colorscheme = "catppuccin-mocha"

if hostname == "Mac.localdomain" then
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
