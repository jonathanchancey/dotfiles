return {
  "nvim-mini/mini.surround",
  opts = {
    custom_surroundings = {
      j = {
        input = { "%{%{%s*().-()%s*%}%}" },
        output = { left = "{{ ", right = " }}" },
      },
    },
  },
}
