require('editor.builtin').setup()
require('editor.plugins').setup()

dofile(vim.g.base46_cache .. 'defaults')
dofile(vim.g.base46_cache .. 'statusline')
