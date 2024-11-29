return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      local wk = require 'which-key'
      wk.add {
        { '<leader>d', group = '[D]ebug', desc = '[D]ebug', icon = '󰃤' },
        { '<leader>r', group = '[R]ename', desc = '[R]ename', icon = '󰑕' },
        { '<leader>s', group = '[S]earch', desc = '[S]earch', icon = '' },
        { '<leader>w', group = '[W]orkspace', desc = '[W]orkspace', icon = '' },
        { '<leader>t', group = '[T]oggle', desc = '[T]oggle', icon = '' },
        { '<leader>G', group = '[G]it', desc = '[G]it', icon = '' },
        { '<leader>j', group = '[J]ump', desc = '[J]ump', icon = '󰒬' },
        { '<leader>f', group = '[F]ile', desc = '[F]ile', icon = '󰪶' },
        { '<leader>G', group = '[G]it', desc = '[G]it', icon = '' },
        { '<leader>g', group = '[G]it', desc = '[G]it', icon = '' },
      }
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'nvim-telescope/telescope-file-browser.nvim' },
    },
    config = function()
      require('telescope').setup {
        vimgrep_arguments = {
          'rg',
          '-L',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '  ',
        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = { 'node_modules' },
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        path_display = { 'truncate' },
        winblend = 0,
        border = {},
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        color_devicons = true,
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
        mappings = {
          n = { ['q'] = require('telescope.actions').close },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      require('editor.themes').telescope()
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'file_browser')
      pcall(require('telescope').load_extension, 'themes')
      pcall(require('telescope').load_extension, 'terms')
      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      local fb = require('telescope').extensions.file_browser
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>fb', fb.file_browser, { desc = '[F]ile [B]rowse' })
      vim.keymap.set('n', '<leader>fl', function()
        fb.file_browser { cwd = vim.fn.expand '%:p:h', cwd_to_path = true }
      end, { desc = '[F]ind [L]ocal Files' })
      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'stevearc/quicker.nvim',
    event = 'FileType qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup {
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
        vim.keymap.set('n', '<leader>ta', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' }),
      }
    end,
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      local home = vim.fn.expand '$HOME'
      require('chatgpt').setup {
        api_key_cmd = 'gpg --decrypt ' .. home .. '/.secrets/gpt.secret.gpg',
        model = 'gpt-4-1106-preview',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
        popup_input = {
          buf_options = {
            filetype = 'prompt',
          },
        },
      }
      local wk = require 'which-key'
      wk.add {
        { '<leader>c', group = '[C]hat', icon = '󰭹' },
        { '<leader>cc', '<cmd>ChatGPT<cr>', desc = '[C]hat With GPT' },
        { '<leader>ce', '<cmd>ChatGPTEditWithInstruction<cr>', desc = '[C]hat Edit With Instruction', mode = { 'n', 'v' } },
        { '<leader>cg', '<cmd>ChatGPTRun grammar_correction<cr>', desc = '[C]hat Grammar Correction', mode = { 'n', 'v' } },
        { '<leader>ct', '<cmd>ChatGPTRun translate<cr>', desc = '[C]hat Translate', mode = { 'n', 'v' } },
        { '<leader>ck', '<cmd>ChatGPTRun keywords<cr>', desc = '[C]hat Keywords', mode = { 'n', 'v' } },
        { '<leader>cd', '<cmd>ChatGPTRun docstring<cr>', desc = '[C]hat Docstring', mode = { 'n', 'v' } },
        { '<leader>ca', '<cmd>ChatGPTRun add_tests<cr>', desc = '[C]hat Add Tests', mode = { 'n', 'v' } },
        { '<leader>co', '<cmd>ChatGPTRun optimize_code<cr>', desc = '[C]hat Optimize Code', mode = { 'n', 'v' } },
        { '<leader>cs', '<cmd>ChatGPTRun summarize<cr>', desc = '[C]hat Summarize', mode = { 'n', 'v' } },
        { '<leader>cf', '<cmd>ChatGPTRun fix_bugs<cr>', desc = '[C]hat Fix Bugs', mode = { 'n', 'v' } },
        { '<leader>cx', '<cmd>ChatGPTRun explain_code<cr>', desc = '[C]hat Explain Code', mode = { 'n', 'v' } },
        { '<leader>cr', '<cmd>ChatGPTRun roxygen_edit<cr>', desc = '[C]hat Roxygen Edit', mode = { 'n', 'v' } },
        { '<leader>cl', '<cmd>ChatGPTRun code_readability_analysis<cr>', desc = '[C]hat Code Readability Analysis', mode = { 'n', 'v' } },
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim', -- optional
      'folke/which-key.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
}
