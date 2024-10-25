return {
  {
    'NvChad/base46',
    branch = 'v3.0',
    build = function()
      require('base46').load_all_highlights()
    end,
  },
  {
    'NvChad/ui',
    branch = 'v3.0',
    lazy = false,
    config = function()
      require 'nvchad'
    end,
  },
  {
    'NvChad/volt',
    lazy = false,
    config = function()
      require 'volt'
    end
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
