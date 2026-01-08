local M = {}

M.config = function(lp, opts)
  ---@param opts telescope-file-browser.FinderOpts Reconstructed Finder Opts
  local function reset_fb_finder(opts)
    local fb_utils = require "telescope._extensions.file_browser.utils"
    return function(prompt_bufnr)
      local action_state = require "telescope.actions.state"
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local finder = current_picker.finder
      for k, v in pairs(opts) do
        finder[k] = v
      end
      fb_utils.redraw_border_title(current_picker)
      current_picker:refresh(
        finder,
        { new_prefix = fb_utils.relative_path_prefix(finder), reset_prompt = true, multi = current_picker._multi }
      )
    end
  end
  opts.extensions.file_browser = {
    mappings = {
      ["n"] = {
        ["gc"] = reset_fb_finder {
          path = vim.loop.cwd(),
          files = false,
          depth = false,
          hidden = false,
          no_ignore = false,
        },
      },
    },
    browse_files = function(opts)
      opts.depth = 1
      return require("telescope._extensions.file_browser.finders").browse_files(opts)
    end,
  }
  require("telescope").setup(opts)
  pcall(require("telescope").load_extension, "file_browser")
  local map = vim.keymap.set
  map("n", "<leader><leader>", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
  map("n", "<leader>fr", "<cmd>Telescope live_grep<CR>", { desc = "telescope [f]ile g[r]ep" })
  map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>", { desc = "telescope [f]ile [b]rowser" })
  map("n", "<leader>fl", "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "telescope [f]ile [l]ocal" })
  map(
    "n",
    "<leader>fd",
    "<CMD>Telescope file_browser files=false depth=false<CR>",
    { desc = "telescope [f]ile [d]irectories" }
  )
  end

return M
