return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  config = function()
    -- <Plug> targets require a recursive mapping (remap = true)
    vim.keymap.set("n", "<C-x>", "<Plug>(VM-Find-Under)", { remap = true })
  end,
}
