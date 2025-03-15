vim.keymap.set("n", "<leader>ee", ':Alpha<CR>' , { desc = "Open Greeter Window (Alpha)" })
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "Open Command Line Window" })

-- Clear search highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show [D]iagnostic [E]rror" })
-- vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

-- Increment/Decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<C-t>", ":TodoTelescope<CR>", { desc = "Open [T]odo Window" })

-- Treesiter Context Jumping to Context (Upwards)
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Go to Previous [C]ontext" })
