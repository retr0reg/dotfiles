return {
  -- ─── colorscheme ─────────────────────────────────────────────
  {
    "datsfilipe/vesper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vesper").setup {
        transparent = false,
        italics = {
          comments = true,
          keywords = false,
          functions = false,
          strings = false,
          variables = false,
        },
      }
      vim.cmd.colorscheme "vesper"
    end,
  },

  -- ─── treesitter ──────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- ─── telescope ───────────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = function()
      return {
        defaults = {
          prompt_prefix = "  ",
          -- selection_caret and entry_prefix MUST be the same display width,
          -- otherwise entries gain/lose leading padding as the selection moves
          selection_caret = "> ",
          entry_prefix = "  ",
          path_display = { "truncate" },
          file_ignore_patterns = { "node_modules", ".git/", "__pycache__", ".venv" },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- ─── LSP ─────────────────────────────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "pyright", "lua_ls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local buf = ev.buf
          local m = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
          end
          m("gd", vim.lsp.buf.definition, "LSP definition")
          m("gD", vim.lsp.buf.declaration, "LSP declaration")
          m("gi", vim.lsp.buf.implementation, "LSP implementation")
          m("gr", vim.lsp.buf.references, "LSP references")
          m("K", vim.lsp.buf.hover, "LSP hover")
          m("<leader>rn", vim.lsp.buf.rename, "LSP rename")
          m("<leader>ca", vim.lsp.buf.code_action, "LSP code action")
          m("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
          m("]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      -- shared capabilities for every server (nvim-cmp)
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      vim.lsp.config("pyright", {
        filetypes = { "python" },
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.enable { "pyright", "lua_ls" }
    end,
  },

  -- ─── completion ──────────────────────────────────────────────
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end,
  },

  -- ─── formatting ──────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.conform",
  },

  -- ─── statusline ──────────────────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      -- passive harpoon preview in the statusline: 1 [2] 3 4
      { "abeldekat/harpoonline", version = "*" },
    },
    config = function()
      local Harpoonline = require "harpoonline"
      Harpoonline.setup {
        icon = "", -- disable the fish-hook icon
        formatter = "short", -- compact [2/4] style
        on_update = function()
          require("lualine").refresh()
        end,
      }

      require("lualine").setup {
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_c = {
            "filename",
            {
              Harpoonline.format,
              -- hide entirely when the harpoon list is empty
              cond = function()
                local ok, harpoon = pcall(require, "harpoon")
                return ok and harpoon:list():length() > 0
              end,
            },
          },
        },
      }
    end,
  },

  -- ─── which-key ───────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- ─── gitsigns ────────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- ─── misc ────────────────────────────────────────────────────
  {
    "benomahony/uv.nvim",
    opts = { picker_integration = true },
  },
  {
    "nemanjamalesija/smart-paste.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
}
