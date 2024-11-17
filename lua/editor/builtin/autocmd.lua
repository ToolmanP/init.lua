local M = {}
M.setup = function()
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })
  vim.api.nvim_create_autocmd('bufenter', {
    pattern = '*',
    callback = function()
      local config = require 'nvconfig'
      if vim.bo.ft ~= 'NvTerm_sp' then
        vim.print(vim.bo.ft)
        vim.opt.statusline = "%!v:lua.require('nvchad.stl." .. config.ui.statusline.theme .. "')()"
      else
        vim.opt.statusline = '%#normal# '
      end
    end,
  })
end

return M
