local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.ruby_lsp.setup({
  capabilities = capabilities,
  cmd = { vim.fn.expand("~/.rbenv/versions/3.2.2/bin/ruby-lsp") },
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
  },
})

--     vim.api.nvim_create_autocmd("BufEnter", {
--       pattern = { 'Fastfile', 'Appfile', 'Matchfile', 'Pluginfile', 'Podfile' },
--       callback = function()
--         vim.o.filetype = "ruby"
--       end,
--     })

