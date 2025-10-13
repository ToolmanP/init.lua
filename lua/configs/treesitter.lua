local M = {}

M.config = function()
  require("nvim-treesitter.configs").setup {
    auto_install = true,
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["am"] = { query = "@function.outer", desc = "Select the outer part of a function or method" },
          ["im"] = { query = "@function.inner", desc = "Select the inner part of a function or method" },
          ["ic"] = { query = "@class.inner", desc = "Select the inner part of a class or method" },
          ["ac"] = { query = "@class.outer", desc = "Select the outer part of a class or method" },
          ["ib"] = { query = "@block.inner", desc = "Select the inner block of a class or method" },
          ["ab"] = { query = "@block.outer", desc = "Select the outer block of a class or method" },
          ["iv"] = { query = "@parameter.inner", desc = "Select the inner block of a class or method" },
          ["av"] = { query = "@parameter.outer", desc = "Select the outer block of a class or method" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next = {
          ["]b"] = { query = "@block.outer", desc = "Goto the next block" },
          ["]v"] = { query = "@parameter.outer", desc = "Goto the next parameter" },
        },
        goto_previous = {
          ["[b"] = { query = "@block.outer", desc = "Goto the previous block" },
          ["[v"] = { query = "@parameter.outer", desc = "Goto the previous parameter" },
        },
      },
    },
  }
end

return M
