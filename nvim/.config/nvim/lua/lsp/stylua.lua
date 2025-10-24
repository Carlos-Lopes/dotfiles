vim.lsp.config("stylua-language-server", {
  cmd = { "stylua", "--lsp" },
  filetypes = { "lua" },
  root_markers = { ".stylua.toml", "stylua.toml", ".editorconfig" },
})

vim.lsp.enable("stylua-language-server")
