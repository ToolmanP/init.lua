return {
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config

    opts = {},
    -- stylua: ignore
    keys = {
      { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "<leader>jt", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<leader>js", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'rainzm/flash-zh.nvim',
    event = 'VeryLazy',
    dependencies = 'folke/flash.nvim',
    keys = {
      {
        '<leader>jc',
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
