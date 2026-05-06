-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_create_user_command(
  "PushKeymap",
  "silent !(cd ~/.dotfiles/keymaps/ && git add . && git commit -m 'auto' && git push)",
  {}
)
vim.api.nvim_create_user_command("PullKeymap", "silent !(cd ~/.dotfiles/keymaps/ && git pull)", {})
vim.cmd("PullKeymap")
vim.cmd("PushKeymap")

vim.keymap.set("t", "<C-n>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>")
vim.keymap.set("n", "<M-w>", function()
  Snacks.bufdelete()
end)
vim.keymap.set("n", "<M-q>", "ZZ")
vim.keymap.set("n", "sb", "<cmd>set scb<cr>")
vim.keymap.set("n", "<M-f>", ":%s/<C-r>+//g<left><left>")
vim.keymap.set("x", "<M-f>", "y0k/<C-r>+<cr>")
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)

-- switch left/right
vim.keymap.set("n", "<M-h>", "xhP")
vim.keymap.set("n", "<M-l>", "xp")

vim.keymap.set("x", "<M-h>", "ygvxhP/<C-r>+<cr>vgn")
vim.keymap.set("x", "<M-H>", "ygvxBP/<C-r>+<cr>vgn")
vim.keymap.set("x", "<M-l>", "ygvxp/<C-r>+<cr>vgn")
vim.keymap.set("x", "<M-L>", "ygvxEp/<C-r>+<cr>vgn")
