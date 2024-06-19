local M = {}

local merge_plugins = function(tables)
  local result = {}
  for _, table in ipairs(tables) do
    for _, v in ipairs(table) do
      result[#result + 1] = v
    end
  end
  return result
end

M.setup = function()
  local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  end ---@diagnostic disable-next-line: undefined-field
  vim.opt.rtp:prepend(lazypath)

  local autopairs = require "editor.plugins.autopairs"
  local cmp = require "editor.plugins.cmp"
  local formatter = require "editor.plugins.formatter"
  local git = require "editor.plugins.git"
  local interface = require "editor.plugins.interface"
  local linter = require "editor.plugins.linter"
  local lsp = require "editor.plugins.lsp"
  local nuance = require "editor.plugins.nuance"
  local treesitters = require "editor.plugins.treesitters"
  local rice = require "editor.plugins.rice"

  local plugins = merge_plugins({
    rice,
    lsp,
    cmp,
    git,
    linter,
    nuance,
    interface,
    autopairs,
    formatter,
    treesitters
  })

  local lazy_opts = {
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  }

  require('lazy').setup(plugins,lazy_opts)
end

return M
