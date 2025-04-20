return {
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'altermo/ultimate-autopair.nvim',
    event = { 'InsertEnter', 'CmdlineEnter' },
    branch = 'v0.6', --recommended as each new version will have breaking changes
    config = function()
      require('ultimate-autopair').setup {
        bs = {
          map = '<A-bs>',
          cmap = '<A-bs>',
        },
        fastwarp = {
          multi = true,
          {},
          { faster = true, map = '<C-e>', cmap = '<C-e>' },
        },
        suround = true,
      }
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.sessions').setup()
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config

    opts = {},
    -- stylua: ignore
    keys = {
      { "<c-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "<a-f>", mode = { "n" }, function() require("flash").treesitter() end, desc = "Flash treesitter"},
    }
,
  },
  {
    'rainzm/flash-zh.nvim',
    event = 'VeryLazy',
    dependencies = 'folke/flash.nvim',
    keys = {
      {
        '<c-a>',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash-zh').jump {
            chinese_only = true,
          }
        end,
        desc = 'Flash between Chinese',
      },
    },
  },
  {
    'wakatime/vim-wakatime',
    lazy = false,
  },
}
