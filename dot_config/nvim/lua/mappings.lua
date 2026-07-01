local map = vim.keymap.set

-- personal
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>p", ":!uv run %<CR>", { desc = "Run current Python file" })

-- buffers
-- map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
-- map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
-- map("n", "<leader><leader>", ":b#<CR>", { desc = "Last buffer" })
-- map("n", "<leader>x", ":bdelete<CR>", { desc = "Close buffer" })

-- windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- telescope (defined here so the keys exist before telescope is lazy-loaded)
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })

-- save / quit
-- map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>W", function()
  vim.cmd "w"
  print "file written"
end, { desc = "which_key_ignore" })

map("n", "<leader>Q", function()
  vim.cmd "wqa!"
end, { desc = "which_key_ignore" })

-- highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "no highlight" })

-- manim
map("n", "<leader>mr", function()
  local file = vim.fn.expand "%:p"
  vim.cmd("split | terminal uv run manim -pql " .. file)
end, { desc = "Manim render" })

map("n", "<leader>ms", function()
  local file = vim.fn.expand "%:p"
  vim.cmd("split | terminal uv run manim -pqh -s " .. file)
end, { desc = "Manim render last frame (high quality)" })

local last_mn = nil
map("n", "<leader>mn", function()
  local file = vim.fn.expand "%:p"
  local n = vim.fn.input "animations (e.g. 10 or 10,15): "
  if n == "" then
    return
  end
  last_mn = n
  vim.cmd("split | terminal uv run manim -pql -n " .. n .. " " .. file)
end, { desc = "Manim render specific animations" })

map("n", "<leader>mn.", function()
  if not last_mn then
    vim.notify("no previous <leader>mn invocation", vim.log.levels.WARN)
    return
  end
  local file = vim.fn.expand "%:p"
  vim.cmd("split | terminal uv run manim -pql -n " .. last_mn .. " " .. file)
end, { desc = "Manim repeat last -n render" })
