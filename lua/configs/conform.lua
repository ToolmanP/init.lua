local options = {

  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    sh = { "shellharden" },
    python = function(bufnr)
      vim.print(require("conform").get_formatter_info("ruff_format", bufnr).available)
      return { "ruff_format", "ruff_fix", "ruff_organize_imports" }
    end,
    go = { "gofmt" },
  },
  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
