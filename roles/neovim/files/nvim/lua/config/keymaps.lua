-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>wN", "<cmd>enew<cr>", { desc = "New File in Current Window" })
vim.keymap.set("n", "<D-s>", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("i", "<D-s>", "<Esc><cmd>w<cr>a", { desc = "Save" })

-- remap quit all to quit buffer
vim.keymap.set("n", "<leader>qq", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
