local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.graphql.setup({
  capabilities = capabilities
})
