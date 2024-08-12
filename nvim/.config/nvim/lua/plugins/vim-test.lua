return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  config = function()
    vim.keymap.set("n", "<leader>Tn", ":TestNearest<CR>", { desc = '[T]est [N]earest' })
    vim.keymap.set("n", "<leader>Tf", ":TestFile<CR>", { desc = '[T]est [F]ile' })
    vim.keymap.set("n", "<leader>Ts", ":TestSuite<CR>", { desc = '[T]est [S]uite' })
    vim.keymap.set("n", "<leader>Tl", ":TestLast<CR>", { desc = '[T]est [L]ast' })
    vim.keymap.set("n", "<leader>Tv", ":TestVisit<CR>", { desc = '[T]est [V]isit' })
    vim.cmd("let test#strategy = 'vimux'")
  end,
}
