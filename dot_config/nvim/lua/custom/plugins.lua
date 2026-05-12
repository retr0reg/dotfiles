local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_instaeed = {
        "pyright",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}
return plugins
