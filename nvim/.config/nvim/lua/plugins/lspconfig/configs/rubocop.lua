local lspconfig = require("lspconfig")

lspconfig.rubocop.setup({
  cmd = { vim.fn.expand("~/.rbenv/versions/3.2.2/bin/rubocop"), "--lsp" },
})
