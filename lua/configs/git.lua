local M = {}

M.config = function(lp, opts)
  opts.attach_to_untracked = true
  opts.on_attach = function(bufnr)
    local gitsigns = require "gitsigns"
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal { "]c", bang = true }
      else
        gitsigns.nav_hunk "next"
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal { "[c", bang = true }
      else
        gitsigns.nav_hunk "prev"
      end
    end)

    -- Actions
    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })

    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })

    map("v", "<leader>gs", function()
      gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "git stage Hunks" })

    map("v", "<leader>gr", function()
      gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "git reset Hunks" })

    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "git [s]tage buffer" })
    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git [r]eset buffer" })
    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
    map("n", "<leader>gi", gitsigns.preview_hunk_inline, { desc = "git [i]nline hunk" })

    map("n", "<leader>gb", function()
      gitsigns.blame_line { full = true }
    end, { desc = "git [b]lame" })

    map("n", "<leader>gd", gitsigns.diffthis, { desc = "git [d]iff" })

    map("n", "<leader>gD", function()
      gitsigns.diffthis "~"
    end, { desc = "git [d]iff with [~]" })

    map("n", "<leader>gQ", function()
      gitsigns.setqflist "all"
    end, { desc = "git [q]uickfix" })

    map("n", "<leader>gq", gitsigns.setqflist, { desc = "git [q]uickfix" })

    -- Toggles
    map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "git [b]lame" })
    map("n", "<leader>gw", gitsigns.toggle_word_diff, { desc = "git [w]ord" })

    gitsigns.stage_hunk()
    -- Text object
    map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "hunk" })
  end
  local gitsigns = require "gitsigns"
  gitsigns.setup(opts)
end

return M
