require "nvchad.mappings"

-- add yours here
--

local map = vim.keymap.set
local keydel = vim.keymap.del

keydel("n", "<leader>v")
keydel("n", "<leader>fb")
keydel("n", "<leader>fw")
keydel("n", "<leader>x")

--- diagnostic
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "show diagnostic error messages" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "open diagnostic quickfix list" })
map("n", "<A-Tab>", "<CMD>tabnext<CR>", { desc = "[t]ab Next" })

--- tabufline
map("n", "H", require("nvchad.tabufline").prev, { desc = "[b]uffer prev" })
map("n", "L", require("nvchad.tabufline").next, { desc = "[b]uffer next" })
map("n", "<C-x>", require("nvchad.tabufline").close_buffer, { desc = "[t]ab close" })
