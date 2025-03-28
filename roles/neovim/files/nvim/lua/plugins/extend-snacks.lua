return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
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
