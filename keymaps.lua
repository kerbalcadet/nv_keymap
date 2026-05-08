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

local function literal_pattern(str)
  return "\\V" .. str:gsub("\\", "\\\\")
end

local function start_search_offset()
  search_text = table.concat(vim.fn.getregion(vim.fn.getpos("'<"), vim.fn.getpos("'>"), { type = "v" }), "\n")

  local pattern = literal_pattern(search_text)

  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  local _, match_col = unpack(vim.fn.searchpos(pattern, "Wn"))

  if match_col == 0 then
    return
  end

  offset = (cursor_col + 1) - match_col
end

local function next_search_offset()
  if search_text == "" then
    return
  end

  local pattern = literal_pattern(search_text)
  local row, col = unpack(vim.fn.searchpos(pattern, "W"))

  if row == 0 or col == 0 then
    return
  end

  vim.api.nvim_win_set_cursor(0, {
    row,
    math.max(0, (col - 1) + offset),
  })
end

vim.keymap.set("x", "<C-/>", start_search_offset)
vim.keymap.set("n", "<C-n>", next_search_offset)
