return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = false,
      replace_netrw = false,
    },
    picker = {
      sources = {
        explorer = {
          finder = "mini.files",
          tree = false,
        },
      },
    },
  },
}
