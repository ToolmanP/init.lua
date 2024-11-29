return {
  ['setup'] = function()
    local g = vim.g
    local opt = vim.opt
    local o = vim.o

    g.base46_cache = vim.fn.stdpath 'data' .. '/nvchad/base46/'

    g.mapleader = ' '
    g.maplocalleader = ' '
    -- Set to true if you have a Nerd Font installed and selected in the terminal
    g.have_nerd_font = true
    -- [[ Setting options ]]
    -- See `:help opt`
    -- NOTE: You can change these options as you wish!
    --  For more options, you can see `:help option-list`

    -- Make line numbers default
    opt.number = true

    opt.relativenumber = true
    -- You can also add relative line numbers, to help with jumping.
    --  Experiment for yourself to see if you like it!
    -- opt.relativenumber = true

    -- Enable mouse mode, can be useful for resizing splits for example!
    opt.mouse = 'a'

    -- Don't show the mode, since it's already in the status line
    opt.showmode = false

    -- Sync clipboard between OS and Neo
    --  Remove this option if you want your OS clipboard to remain independent.
    --  See `:help 'clipboard'`
    --
    -- Enable break indent
    opt.breakindent = true

    -- Save undo history
    opt.undofile = true

    -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    opt.ignorecase = true
    opt.smartcase = true

    -- Keep signcolumn on by default
    opt.signcolumn = 'yes'

    -- Decrease update time
    opt.updatetime = 250

    -- Decrease mapped sequence wait time
    -- Displays which-key popup sooner
    opt.timeoutlen = 300
    o.tabstop = 2
    o.shiftwidth = 2
    o.softtabstop = 2
    o.expandtab = false

    -- Configure how new splits should be opened
    opt.splitright = true
    opt.splitbelow = true

    -- Sets how neowill display certain whitespace characters in the editor.
    --  See `:help 'list'`
    --  and `:help 'listchars'`
    opt.list = true
    opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

    -- Preview substitutions live, as you type!
    opt.inccommand = 'split'

    -- Show which line your cursor is on
    opt.cursorline = false

    -- Minimal number of screen lines to keep above and below the cursor.
    opt.scrolloff = 10
    o.laststatus = 3

    -- [[ Basic Keymaps ]]
    --  See `:help keymap.set()`

    -- Set highlight on search, but clear on pressing <Esc> in normal mode
    opt.hlsearch = true

    opt.clipboard = 'unnamedplus'
    local ssh_connection = vim.fn.getenv 'SSH_CONNECTION'
    if ssh_connection ~= vim.NIL then
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy '+',
          ['*'] = require('vim.ui.clipboard.osc52').copy '*',
        },
        paste = {
          ['+'] = require('vim.ui.clipboard.osc52').paste '+',
          ['*'] = require('vim.ui.clipboard.osc52').paste '*',
        },
      }
    end
    opt.colorcolumn = '72'
    o.shell = '/usr/bin/fish'
  end,
}
