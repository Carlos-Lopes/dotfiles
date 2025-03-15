vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "Open Command Line Window" })

-- Clear search highlight on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show [D]iagnostic [E]rror" })

-- Increment/Decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
