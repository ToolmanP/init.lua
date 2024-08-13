local find_uncrustify_config = function()
  local cwd = vim.fn.expand '%:p:h'
  local config = vim.fs.find('uncrustify.cfg', {
    path = cwd,
    upward = true,
    limit = math.huge,
  })
  if config == '' then
    return nil
  end
  return config[1]
end

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
    config = function()
      local opts = {
        notify_on_error = false,
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { { 'prettierd', 'prettier' } },
          json = { 'prettier' },
          jsonc = { 'prettier' },
          yaml = { 'prettier' },
          css = { 'prettier' },
          c = function(bufnr)
            local uncrustify_config = find_uncrustify_config()
            local conform = require 'conform'
            if conform.get_formatter_info('uncrustify', bufnr).available and uncrustify_config then
              conform.formatters.uncrustify = {
                prepend_args = { '-c', uncrustify_config },
              }
              return { 'uncrustify' }
            else
              return { 'clang-format' }
            end
          end,
          cpp = { 'clang-format' },
          python = { 'isort', 'black' },
          sh = { 'shfmt' },
        },
      }
      require('conform').setup(opts)
    end,
  },
}
