local M = {}

M.config = function(lp, opts)
  require("go").setup(opts)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require("go.format").goimports()
    end,
    group = vim.api.nvim_create_augroup("nvim-go-format", { clear = true }),
  })
end

return M
