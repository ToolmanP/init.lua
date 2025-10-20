require "nvchad.mappings"

-- add yours here
--

local map = vim.keymap.set
local keydel = vim.keymap.del

map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })
map("n", "<A-Tab>", "<CMD>tabnext<CR>", { desc = "[T]ab Next" })
map("n", "H", require("nvchad.tabufline").prev, { desc = "Buffer Prev" })
map("n", "L", require("nvchad.tabufline").next, { desc = "Buffer Next" })
map("n", "<leader>fB", "<CMD>Telescope file_browser<CR>", { desc = "File Browser" })
map("n", "<leader>fl", "<CMD>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Local File Browser" })

map(
  "n",
  "<leader>fd",
  "<CMD>Telescope file_browser files=false depth=false<CR>",
  { desc = "Recursive Directories Browser" }
)

keydel("n", "<leader>v")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
