local hostname = vim.fn.hostname()

local colorscheme = "catppuccin-mocha"

if hostname == "Mac.localdomain" or hostname == "om3.local" or hostname == "om3" then
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
