-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local function telescope_start()
  local builtin = require 'telescope.builtin'
  local dap = require 'dap'
  local file_type = vim.bo.filetype
  local cmd = nil

  if file_type == 'python' then
    cmd = { 'fd', '-e', 'py' }
  elseif file_type == 'typescript' or file_type == 'javascript' or file_type == 'html' then
    cmd = { 'fd', '-e', 'js', '-e', 'ts', '-e', 'html' }
  else
    cmd = { 'fd', '-t', 'x', '--no-ignore' }
  end

  local selection = nil

  local opts = {
    prompt_title = 'Dap Start Debugging',
    find_command = cmd,
    attach_mappings = function(prompt_bufnr)
      local actions = require 'telescope.actions'
      local actions_state = require 'telescope.actions.state'
      actions.select_default:replace(function()
        selection = actions_state.get_selected_entry()
        if dap.configurations[file_type] and selection then
          for i, _ in ipairs(dap.configurations[file_type]) do
            if dap.configurations[file_type][i].replace then
              dap.configurations[file_type][i].program = vim.fn.getcwd() .. '/' .. selection.value
            end
          end
        end
        require('telescope').extensions.dap.configurations {
          language_filter = function(lang)
            return lang == file_type
          end,
        }
      end)
      return true
    end,
    previewer = false,
  }
  builtin.find_files(opts)
end

local function setup_llvm()
  local dap = require 'dap'

  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.expand '$HOME/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
  }

  dap.configurations.cpp = {
    {
      name = 'Launch file',
      type = 'cppdbg',
      request = 'launch',
      program = '{file}',
      cwd = '${workspaceFolder}',
      stopAtEntry = true,
      miDebuggerPath = '/usr/bin/gdb',
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailures = false,
        },
      },
      replace = true,
    },
    {
      name = 'Attach QEMU(aarch64)',
      type = 'cppdbg',
      request = 'launch',
      miDebuggerServerAddress = 'localhost:1234',
      program = '{file}',
      cwd = '${workspaceFolder}',
      miDebuggerPath = '/usr/bin/gdb',
      setupCommands = {
        {
          text = '-enable-pretty-printing',
          description = 'enable pretty printing',
          ignoreFailures = false,
        },
      },
      targetArchitecture = 'arm64',
      logging = {
        enabled = true,
        trace = true,
        traceResponse = true,
      },
      MIMode = 'gdb',
      replace = true,
    },
  }

  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
      { 'MunifTanjim/nui.nvim' },
      { 'mfussenegger/nvim-dap-python', ft = { 'python' } },
      { 'leoluz/nvim-dap-go', ft = { 'go' } },
      { 'rcarriga/nvim-dap-ui' },
      { 'nvim-telescope/telescope-dap.nvim' },
    },
    config = function()
      require('editor.themes').setup()
      require('dap-go').setup {}
      require('dap-python').setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      setup_llvm()

      local dap = require 'dap'
      local dapui = require 'dapui'
      local dtelescope = require('telescope').extensions.dap

      vim.keymap.set('n', '<leader>ds', telescope_start, { desc = 'Debug: Start' })
      vim.keymap.set('n', '<leader>dc', function()
        dap.continue { new = false }
      end, { desc = 'Debug: Continue' })

      vim.keymap.set('n', '<leader>dpi', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>dpo', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>dpu', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set({ 'n', 'x' }, '<leader>de', dapui.eval, { desc = 'Debug: Eval the context' })

      vim.keymap.set('n', '<leader>df', dtelescope.frames, { desc = 'Debug: Get Frames' })
      vim.keymap.set('n', '<leader>dl', dtelescope.list_breakpoints, { desc = 'Debug: List Breakpoints' })

      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      vim.keymap.set('n', '<leader>DT', dapui.toggle, { desc = 'Debug: See last session result.' })
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          enabled = false,
        },
        layouts = {
          {
            elements = {
              {
                id = 'repl',
                size = 0.5,
              },
              {
                id = 'console',
                size = 0.5,
              },
            },
            position = 'bottom',
            size = 10,
          },
        },
      }
    end,
  },
}
