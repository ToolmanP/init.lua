return {
  {
    'NvChad/base46',
    branch = 'v2.5',
    build = function()
      require('base46').load_all_highlights()
    end,
  },
  {
    'NvChad/ui',
    branch = 'v2.5',
    lazy = false,
    config = function()
      require 'nvchad'
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    lazy = false,
    opts = { user_default_options = { names = false } },
    config = function(_, opts)
      require('colorizer').setup(opts)
    end,
  },
}
