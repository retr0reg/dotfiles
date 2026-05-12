return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.lspconfig"
    end,
  },

  {
    "benomahony/uv.nvim",
  -- Optional filetype to lazy load when you open a python file
  -- ft = { python }
  -- Optional dependency, but recommended:
  -- dependencies = {
  --   "folke/snacks.nvim"
  -- or
  --   "nvim-telescope/telescope.nvim"
  -- },
    opts = {
      picker_integration = true,
    },
  }

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
