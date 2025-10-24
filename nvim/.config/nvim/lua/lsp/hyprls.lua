vim.lsp.config("hyprls", {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      buffer = bufnr,
      command = { "hyprls" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})

vim.lsp.enable('hyprls')
