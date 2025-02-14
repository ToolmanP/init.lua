local M = {}

M.setup = function()
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
  vim.keymap.set('n', '<A-Tab>', ':tabnext<CR>', { desc = 'Tab Next', silent = true })
  vim.keymap.set('n', '<A-q>', ':tabclose<CR>', { desc = 'Tab Close', silent = true })
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
  vim.keymap.set('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })
  vim.keymap.set({ 'n', 't' }, '<leader>tv', function()
    require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
  end, { desc = 'terminal toggleable vertical term' })
  vim.keymap.set({ 'n', 't' }, '<leader>tf', function()
    require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' }
  end, { desc = 'terminal float term' })
  vim.keymap.set('n', '<C-q>', function()
    require('nvchad.tabufline').close_buffer()
  end, { desc = 'Close Buffer' })
  vim.keymap.set('n', 'L', function()
    require('nvchad.tabufline').next()
  end, { desc = 'buffer goto next' })
  vim.keymap.set('n', 'H', function()
    require('nvchad.tabufline').prev()
  end, { desc = 'buffer goto prev' })
end

return M
