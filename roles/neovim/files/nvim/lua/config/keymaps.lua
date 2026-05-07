-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>wN", "<cmd>enew<cr>", { desc = "New File in Current Window" })
vim.keymap.set("n", "<D-s>", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("i", "<D-s>", "<Esc><cmd>w<cr>a", { desc = "Save" })

local function toggle_markdown_checkbox()
  local line = vim.api.nvim_get_current_line()
  local prefix, checked, text = line:match("^(%s*[-*+]%s+)%[([ xX])%](.*)$")

  if prefix then
    vim.api.nvim_set_current_line(prefix .. (checked == " " and "[x]" or "[ ]") .. text)
  else
    vim.api.nvim_set_current_line((line:gsub("^(%s*)", "%1- [ ] ", 1)))
  end
end

vim.keymap.set("n", "<D-l>", function()
  toggle_markdown_checkbox()
end, { desc = "Toggle Markdown Checkbox" })

vim.keymap.set("n", "<leader>fy", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%:p"))
end, { desc = "Copy filename+line to clipboard" })

-- remap quit all to quit buffer
vim.keymap.set("n", "<leader>qq", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
