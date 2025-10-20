local M = {}

M.config = function()
  require("nvim-treesitter").setup {}

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "asm",
      "go",
      "python",
      "c",
      "cpp",
      "lua",
      "rust",
      "typescript",
      "javascript",
      "sh",
      "bash",
      "fish",
      "json",
      "yaml",
      "toml",
      "ecma",
      "ruby",
      "markdown",
    },
    callback = function()
      vim.treesitter.start()
    end,
  })

  require("nvim-treesitter-textobjects").setup {
    select = {
      enable = true,
      lookahead = true,
    },
    move = {
      enable = true,
      set_jumps = true,
    },
  }

  local select_textobject = function(query_string)
    return function()
      require("nvim-treesitter-textobjects.select").select_textobject(query_string, "textobjects")
    end
  end
  local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
  local map = vim.keymap.set

  local gt = function(direction, query_string)
    return function()
      return require("nvim-treesitter-textobjects.move")["goto_" .. direction](query_string, "textobjects")
    end
  end

  map({ "x", "o" }, "am", select_textobject "@function.outer")
  map({ "x", "o" }, "im", select_textobject "@function.inner")
  map({ "x", "o" }, "ac", select_textobject "@class.outer")
  map({ "x", "o" }, "ic", select_textobject "@class.inner")
  map({ "x", "o" }, "ab", select_textobject "@block.outer")
  map({ "x", "o" }, "ib", select_textobject "@block.inner")
  map({ "x", "o" }, "av", select_textobject "@parameter.outer")
  map({ "x", "o" }, "iv", select_textobject "@parameter.inner")

  map({ "n", "x", "o" }, "]b", gt("next", "@block.outer"))
  map({ "n", "x", "o" }, "]v", gt("next", "@parameter.outer"))
  map({ "n", "x", "o" }, "[b", gt("previous", "@block.outer"))
  map({ "n", "x", "o" }, "[v", gt("previous", "@parameter.outer"))
  map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
end

return M
