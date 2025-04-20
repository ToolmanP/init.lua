return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        disable = { 'latex' },
        additional_vim_regex_highlighting = { 'latex', 'markdown' },
      },
      indent = { enable = true },
    },
    ignore_install = { 'latex', 'tex' },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = false,
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>np'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>pp'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next = {
              ['ns'] = '@scope.inner',
              ['nb'] = { query = '@block.outer', desc = 'Next Block inner start' },
              ['<leader>nf'] = { query = '@function.inner', desc = 'Next function inner start' },
              ['<leader>nF'] = { query = '@function.outer', desc = 'Next function outer start' },
              ['<leader>nc'] = { query = '@class.inner ', desc = 'Next class inner start' },
              ['<leader>nC'] = { query = '@class.outer', desc = 'Next class outer start' },
              ['nz'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
            },
            goto_previous = {
              ['ps'] = '@scope.inner',
              ['pb'] = { query = '@block.outer', desc = 'Next Block inner start' },
              ['<leader>pf'] = { query = '@function.inner', desc = 'Next function inner start' },
              ['<leader>pF'] = { query = '@function.outer', desc = 'Next function outer start' },
              ['<leader>pc'] = { query = '@class.inner ', desc = 'Next class inner start' },
              ['<leader>pC'] = { query = '@class.outer', desc = 'Next class outer start' },
              ['pz'] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
            },
          },
        },
      }
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter' },
    },
    event = 'BufRead',
    config = function()
      dofile(vim.g.base46_cache .. 'rainbowdelimiters')
      local rainbow_delimiters = require 'rainbow-delimiters'
      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          latex = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end,
  },
}
