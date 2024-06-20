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

        format = function(_, item)
          local icons = require 'nvchad.icons.lspkind'
          local icon = (cmp_ui.icons and icons[item.kind]) or ''

          if cmp_style == 'atom' or cmp_style == 'atom_colored' then
            icon = ' ' .. icon .. ' '
            item.menu = cmp_ui.lspkind_text and '   (' .. item.kind .. ')' or ''
            item.kind = icon
          else
            icon = cmp_ui.lspkind_text and (' ' .. icon .. ' ') or icon
            item.kind = string.format('%s %s', icon, cmp_ui.lspkind_text and item.kind or '')
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
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
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
        },
      }
    end,
  },
}
