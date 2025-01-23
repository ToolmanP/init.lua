local M = {}

M.lsp = function()
	dofile(vim.g.base46_cache .. "lsp")
	require("nvchad.lsp")
end

M.default = function()
	dofile(vim.g.base46_cache .. "defaults")
	dofile(vim.g.base46_cache .. "statusline")
end

M.cmp = function()
	dofile(vim.g.base46_cache .. "cmp")
end

M.neogit = function()
	dofile(vim.g.base46_cache .. "neogit")
end

M.telescope = function()
	dofile(vim.g.base46_cache .. "telescope")
end

M.rainbow = function()
	dofile(vim.g.base46_cache .. "rainbowdelimiters")
end

M.dap = function()
	dofile(vim.g.base46_cache .. "dap")
	require("nvchad.dap")
end

M.setup = function()
	require("base46").load_all_highlights()
end

return M
