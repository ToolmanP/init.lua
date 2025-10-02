local M = {}

M.nmap = function(lhs, f, com)
  vim.keymap.set("n", lhs, f, { desc = com })
end
M.ndel = function(lhs)
  vim.keymap.del("n", lhs)
end

return M
