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
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)

-- highlight word
vim.keymap.set("n", "vv", "viw")
vim.keymap.set("n", "VV", "viW")

-- move buffers
vim.keymap.set("n", "<M-H>", "<cmd>BufferLineMovePrev<cr>")
vim.keymap.set("n", "<M-L>", "<cmd>BufferLineMoveNext<cr>")

-- switch left/right
vim.keymap.set("n", "<M-h>", "xhP")
vim.keymap.set("n", "<M-l>", "xp")

vim.keymap.set("x", "<M-h>", "ygvxhP/<C-r>+<cr>vgn")
vim.keymap.set("x", "<M-H>", "ygvxBP/<C-r>+<cr>vgn")
vim.keymap.set("x", "<M-l>", "ygvxp/<C-r>+<cr>vgn")
vim.keymap.set("x", "<M-L>", "ygvxEp/<C-r>+<cr>vgn")

-- search / ctrl+d ish
local search_text = ""
local offset = 0
local function start_search_offset()
  search_text = vim.fn.getreg("s")
  --local c_col = vim.api.nvim_win_get_cursor(0)[2]
  --local p_col = vim.fn.searchpos(search_text, "cn")[2]
  --offset = c_col - p_col
  vim.cmd("normal! <esc>")
end

local function next_search_offset()
  local row, col, _ = unpack(vim.fn.searchpos(search_text, "W"))
  vim.api.nvim_win_set_cursor(0, { row, col + offset })
end

vim.keymap.set("x", "<C-/>", start_search_offset)
vim.keymap.set("n", "<C-n>", next_search_offset)
