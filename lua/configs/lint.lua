local M = {}

M.config = function()
  require("lint").linters_by_ft = {
    python = { "ruff" },
  }
end
return M
