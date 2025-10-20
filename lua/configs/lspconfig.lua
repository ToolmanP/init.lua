require("nvchad.configs.lspconfig").defaults()

local ndel = require("utils").ndel
local nmap = require("utils").nmap

ndel "grr"
ndel "gri"

nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
nmap("gp", require("telescope.builtin").diagnostics, "[G]oto [P]roblems")

nmap("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
nmap("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

nmap("<leader>Ld", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
nmap("<leader>Ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
nmap("<leader>Lw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

local servers = { "html", "cssls", "clangd", "luals", "gopls", "basedpyright", "bashls", "copilot", "ruby_lsp" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
