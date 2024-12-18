local lsp_keymap = function(event, client)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end
  local wk = require 'which-key'
  wk.add {
    { '<leader>L', group = '[L]SP', icon = '' },
  }
  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('<leader>Ld', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  map('<leader>Ls', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  map('<leader>Lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  map('<leader>rn', require 'nvchad.lsp.renamer', '[R]e[n]ame')
  map('<leader>Lc', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, '[T]oggle Inlay [H]ints')
  end
end

local servers = {
  -- lua/neovim
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = { globals = { 'vim' }, disable = { 'missing-fields' } },
      },
    },
  },
  -- bash
  bashls = {},
  -- fish
  -- fish_lsp = {},
  -- c/c++
  clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--suggest-missing-includes',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--cross-file-rename',
      '--offset-encoding=utf-16',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  },
  -- golang
  gopls = {},
  -- typst
  typst_lsp = {},
  -- toml
  taplo = {},
  -- python
  basedpyright = {
    settings = {
      pyright = {
        disableOrganizeImports = true, -- Using Ruff
      },
      python = {
        analysis = {
          ignore = { '*' }, -- Using Ruff
          typeCheckingMode = 'off', -- Using mypy
        },
      },
    },
  },
  -- typescript/javascript/json
  ts_ls = {},
  eslint = {},
  -- haskell
  hls = {},
  -- ocaml
  ocamllsp = {},
}

local ensured_installed = {
  'stylua',
  'prettier',
}

------------------------------------------------------------------------------------------

local lsp_callback = function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  lsp_keymap(event, client)

  if client and client.server_capabilities.documentHighlightProvider then
    local highlight_augroup = vim.api.nvim_create_augroup('custom-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('custom-lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'custom-lsp-highlight', buffer = event2.buf }
      end,
    })
  end
end

return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      { 'folke/which-key.nvim' },
      {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {},
        config = function(_, opts)
          require('lsp_signature').setup(opts)
        end,
      },
    },

    config = function()
      require('editor.themes').lsp()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('custom-lsp-attach', { clear = true }),
        callback = lsp_callback,
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    dependencies = {
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      require('mason').setup()
      require('mason-tool-installer').setup { ensure_installed = ensured_installed }
      local lspconfig = require 'lspconfig'
      for server, opts in pairs(servers) do
        lspconfig[server].setup(opts)
      end
    end,
  },
  --- Language specific
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = function()
        return {
          tools = {},
          server = {
            on_attach = function(client, bufnr) end,
            default_settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allTargets = false,
                },
              },
            },
          },
          -- DAP configuration
          dap = { autoload_configurations = false },
        }
      end
    end,
    ft = { 'rust' },
  },
  {},
  {
    'wlh320/rime-ls',
    enabled = false,
    dependencies = { {
      'neovim/nvim-lspconfig',
    } },
    config = function()
      local lspconfig = require 'lspconfig'
      local configs = require 'lspconfig.configs'
      if not configs.rime_ls then
        configs.rime_ls = {
          default_config = {
            name = 'rime_ls',
            cmd = { 'rime_ls' },
            -- cmd = vim.lsp.rpc.connect('127.0.0.1', 9257),
            filetypes = { '*' },
            single_file_support = true,
          },
          settings = {},
          docs = {
            description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
          },
        }
      end

      local rime_on_attach = function(client, _)
        local toggle_rime = function()
          client.request('workspace/executeCommand', { command = 'rime-ls.toggle-rime' }, function(_, result, ctx, _)
            if ctx.client_id == client.id then
              vim.g.rime_enabled = result
            end
          end)
        end
        -- keymaps for executing command
        vim.keymap.set('i', '<C-x>', toggle_rime, { desc = 'Rime Toggle' })
        vim.keymap.set('n', '<leader>rs', function()
          vim.lsp.buf.execute_command { command = 'rime-ls.sync-user-data' }
        end, { desc = 'Rime User Sync' })
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      lspconfig.rime_ls.setup {
        init_options = {
          enabled = vim.g.rime_enabled,
          shared_data_dir = '/usr/share/rime-data',
          user_data_dir = '~/.local/share/rime-ls',
          log_dir = '~/.local/share/rime-ls',
          max_candidates = 9,
          trigger_characters = {},
          schema_trigger_character = '&', -- [since v0.2.0] 当输入此字符串时请求补全会触发 “方案选单”
        },
        on_attach = rime_on_attach,
        capabilities = capabilities,
      }
    end,
  },
}
