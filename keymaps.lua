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

local function next_search_offset(fwd)
  fwd = (fwd == true)

  if fwd then
    vim.cmd("/" .. search_text .. "/s+" .. offset)
  else
    vim.cmd("?" .. search_text .. "?b+" .. offset)
  end
end

local function start_search_offset(search_text_)
  search_text = search_text_ or vim.fn.expand("<cword>")

  local c_col = vim.api.nvim_win_get_cursor(0)[2]
  local p_col = vim.fn.searchpos(search_text, "bcW")[2]
  offset = c_col - p_col

  vim.cmd.normal({ args = { "<esc>", (offset + 1) .. "l" } })
  vim.fn.setreg("/", search_text)
  vim.cmd("set hlsearch")
end

local function start_yanked_search_offset()
  start_search_offset(vim.fn.getreg("+"))
end

vim.keymap.set("n", "<C-/>", start_search_offset, { remap = true })
vim.keymap.set("n", "<C-M-/>", start_yanked_search_offset, { remap = true })
vim.keymap.set("n", "<C-n>", function()
  next_search_offset(true)
end, { remap = true })

vim.keymap.set("n", "<C-p>", function()
  next_search_offset(false)
end, { remap = true })
