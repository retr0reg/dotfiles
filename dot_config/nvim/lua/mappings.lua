require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tt", ":lua require('base46').toggle_transparency()<CR>", { noremap = true, silent = true, desc = "Toggle Background Transparency" })

map("n", "<leader>p", ":!uv run %<CR>", { desc = "Run current Python file" })

-- Buffer navigation mappings from custom/mappings.lua
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader><leader>", ":b#<CR>", { desc = "Last buffer" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
