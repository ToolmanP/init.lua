dofile(vim.g.base46_cache .. "git")
dofile(vim.g.base46_cache .. "neogit")
local M = {}
M.config = function()
  local map = vim.keymap.set
  local neogit = require "neogit"
  neogit.setup {}
  map({ "n" }, "<leader>GR", function()
    neogit.open { "rebase" }
  end, { desc = "git rebase" })
  map({ "n" }, "<leader>Gc", function()
    neogit.open { "commit" }
  end, { desc = "git commit" })
  map({ "n" }, "<leader>GC", function()
    neogit.open { "cherry-pick" }
  end, { desc = "git cherry-pick" })
  map({ "n" }, "<leader>Gr", function()
    neogit.open { "reset" }
  end, { desc = "git reset" })
end
return M
