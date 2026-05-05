-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- test

vim.api.nvim_create_user_command(
  "PushKeymap",
  "silent !(cd ~/.dotfiles/keymaps/ && git add . && git commit -m 'auto' && git push)",
  {}
)
vim.api.nvim_create_user_command("PullKeymap", "silent !(cd ~/.dotfiles/keymaps/ && git -q pull)", {})
vim.cmd("PullKeymap")

vim.keymap.set("t", "<C-n>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
vim.keymap.set("n", "<M-w>", function()
  Snacks.bufdelete()
end)
vim.keymap.set("n", "<M-q>", "ZZ")
vim.keymap.set("n", "<leader>q", "ZZ", { remap = true })
vim.keymap.set("n", "sb", "<cmd>set scb<cr>")
vim.keymap.set({ "n", "x" }, "<M-f>", ":%s/<C-r>+//g<left><left>")
vim.keymap.set({ "n", "x" }, "<M-F>", "0k/<C-r>+<cr>")
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
