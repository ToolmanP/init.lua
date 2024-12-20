return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require('copilot_cmp').setup()
        end,
        dependencies = {
          {
            'zbirenbaum/copilot.lua',
            config = function()
              require('copilot').setup {
                panel = {
                  enabled = false,
                },
                suggestion = {
                  enabled = false,
                },
              }
            end,
          },
        },
      },
    },
    config = function()
      require('editor.themes').cmp()
      local cmp_ui = require('nvconfig').ui.cmp
      local cmp_style = cmp_ui.style
      local field_arrangement = {
        atom = { 'kind', 'abbr', 'menu' },
        atom_colored = { 'kind', 'abbr', 'menu' },
      }

      local formatting_style = {
        fields = field_arrangement[cmp_style] or { 'abbr', 'kind', 'menu' },

        format = function(entry, item)
          local icons = require 'nvchad.icons.lspkind'
          local format_kk = require 'nvchad.cmp.format'
          item.abbr = item.abbr .. ' '
          item.menu = cmp_ui.lspkind_text and item.kind or ''
          item.menu_hl_group = atom_styled and 'LineNr' or 'CmpItemKind' .. (item.kind or '')
          item.kind = (icons[item.kind] or '') .. ' '

          if not cmp_ui.icons_left then
            item.kind = ' ' .. item.kind
          end

          if cmp_ui.format_colors.tailwind then
            format_kk.tailwind(entry, item)
          end

          return item
        end,
      }

      local function border(hl_name)
        return {
          { '╭', hl_name },
          { '─', hl_name },
          { '╮', hl_name },
          { '│', hl_name },
          { '╯', hl_name },
          { '─', hl_name },
          { '╰', hl_name },
          { '│', hl_name },
        }
      end

      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        enabled = function()
          local file_type = vim.api.nvim_buf_get_option(0, 'filetype')
          local buf_type = vim.api.nvim_buf_get_option(0, 'buftype')
          if file_type == 'prompt' or buf_type == 'prompt' or buf_type == 'ChatPrompt' then
            return false
          end
          return true
        end,
        window = {
          completion = {
            side_padding = (cmp_style ~= 'atom' and cmp_style ~= 'atom_colored') and 1 or 0,
            winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None',
            scrollbar = false,
          },
          documentation = {
            border = border 'CmpBorder',
            winhighlight = 'Normal:CmpDoc',
          },
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        completion = { completeopt = 'menu,menuone,noinsert' },
        formatting = formatting_style,

        mapping = cmp.mapping.preset.insert {
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<Space>'] = cmp.mapping(function(fallback)
            local entry = cmp.get_selected_entry()
            if entry == nil then
              entry = cmp.core.view:get_first_entry()
            end
            if entry and entry.source.name == 'nvim_lsp' and entry.source.source.client.name == 'rime_ls' then
              cmp.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
              }
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping(function(fallback)
            local entry = cmp.get_selected_entry()
            if entry == nil then
              entry = cmp.core.view:get_first_entry()
            end
            if entry and entry.source.name == 'nvim_lsp' and entry.source.source.client.name == 'rime_ls' then
              cmp.abort()
            else
              if entry ~= nil then
                cmp.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = true,
                }
              else
                fallback()
              end
            end
          end, { 'i', 's' }),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'copilot' },
        },
      }
    end,
  },
}
