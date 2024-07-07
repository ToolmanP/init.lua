return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>fm',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { { 'prettierd', 'prettier' } },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        css = { 'prettier' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
      },
    },
  },
}
