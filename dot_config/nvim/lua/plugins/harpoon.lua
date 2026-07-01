local function list()
  return require("harpoon"):list()
end

-- open the harpoon list in a telescope picker
local function toggle_telescope()
  local conf = require("telescope.config").values
  local file_paths = {}
  for _, item in ipairs(list().items) do
    table.insert(file_paths, item.value)
  end
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

local function sel(n)
  return function()
    list():select(n)
  end
end

local function replace(n)
  return function()
    list():replace_at(n)
  end
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup()
  end,
  -- single source of truth: each entry is both the load-trigger and the action.
  -- desc = "which_key_ignore" keeps them out of the which-key popup.
  keys = {
    {
      "<leader>a",
      function()
        list():add()
      end,
      desc = "which_key_ignore",
    },
    { "<C-e>", toggle_telescope, desc = "which_key_ignore" },
    { "<leader>E", function() list():clear() end, desc = "which_key_ignore" },
    { "<leader>q", sel(1), desc = "which_key_ignore" },
    { "<leader>w", sel(2), desc = "which_key_ignore" },
    { "<leader>e", sel(3), desc = "which_key_ignore" },
    { "<leader>r", sel(4), desc = "which_key_ignore" },
    { "<leader><C-q>", replace(1), desc = "which_key_ignore" },
    { "<leader><C-w>", replace(2), desc = "which_key_ignore" },
    { "<leader><C-e>", replace(3), desc = "which_key_ignore" },
    { "<leader><C-r>", replace(4), desc = "which_key_ignore" },
  },
}
