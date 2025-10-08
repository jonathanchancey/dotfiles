return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      ["d"] = {
        input = { "'''().-()'''" }, -- Added capture groups
        output = { left = "'''\n", right = "\n'''" },
      },
      ["`"] = {
        input = { "```&quot;, &quot;```" },
        output = { left = "```\n&quot;, right = &quot;\n```" },
      },
    },
  },
}
