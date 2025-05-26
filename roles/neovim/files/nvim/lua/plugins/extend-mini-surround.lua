-- See https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-surround.txt
require("mini.surround").setup({
  custom_surroundings = {
    ["d"] = {
      -- input = { "'''", "'''" },
      input = { "'''().-()'''" }, -- Added capture groups
      output = { left = "'''\n", right = "\n'''" },
    },
    ["`"] = {
      input = { "```", "```" },
      output = { left = "```\n", right = "\n```" },
    },
  },
})
