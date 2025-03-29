return {
  "echasnovski/mini.files",
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files at directory of current file",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files at cwd",
    },
    {
      "<leader>fm",
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files at root",
    },
  },
  opts = {
    windows = {
      preview = true,
      width_nofocus = 20,
      width_focus = 30,
      width_preview = 100,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
}
