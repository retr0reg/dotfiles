You want to…: Change vim options (line numbers, tabs, search, clipboard, etc.)
Edit: lua/options.lua

You want to…: Add/change a keymap
Edit: lua/mappings.lua

You want to…: Add a new plugin, remove one, or tweak a plugin's opts
Edit: lua/plugins/init.lua

You want to…: Tweak the colorscheme (transparency, italics)
Edit: lua/plugins/init.lua → vesper.nvim block

You want to…: Add an LSP server (e.g. tsserver, gopls)
Edit: lua/plugins/init.lua → mason-lspconfig ensure_installed and nvim-lspconfig config (add lspconfig.<name>.setup({...}))

You want to…: Change LSP keymaps (gd, K, <leader>rn, etc.)
Edit: lua/plugins/init.lua → nvim-lspconfig block, inside the LspAttach autocmd

You want to…: Add/change a formatter (e.g. black for python, prettier for js)
Edit: lua/configs/conform.lua

You want to…: Enable format-on-save
Edit: lua/configs/conform.lua → uncomment format_on_save block

You want to…: Add treesitter parsers for new languages
Edit: lua/plugins/init.lua → nvim-treesitter → ensure_installed

You want to…: Change completion behavior (Tab, Enter, sources)
Edit: lua/plugins/init.lua → nvim-cmp block

You want to…: Tweak statusline
Edit: lua/plugins/init.lua → lualine.nvim opts

You want to…: Change telescope ignore patterns or prompt
Edit: lua/plugins/init.lua → telescope.nvim opts

You want to…: Bootstrap behavior, autocmds (yank highlight), leader key
Edit: init.lua

You want to…: Lazy.nvim install/UI behavior, disabled built-in plugins
Edit: lua/configs/lazy.lua
