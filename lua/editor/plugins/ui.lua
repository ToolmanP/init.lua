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
      dofile(vim.g.base46_cache .. 'defaults')
      dofile(vim.g.base46_cache .. 'statusline')
    end,
  },
}
