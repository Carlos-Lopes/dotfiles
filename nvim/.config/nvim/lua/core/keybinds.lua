local function nmap(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

nmap("<leader><Esc>", "<cmd>nohlsearch<CR>", "Clear Search Highlight")
nmap("<Esc>", "<cmd>nohlsearch<CR>", "Clear Search Highlight")
nmap("<leader>+", "<C-a>", "Increment Number")
nmap("<leader>-", "<C-x>", "Decrement Number")
nmap("<leader>de", vim.diagnostic.open_float, "Show Diagnostic Error")
nmap("<leader>ex", vim.cmd.Ex, "Open Command Line Window")
