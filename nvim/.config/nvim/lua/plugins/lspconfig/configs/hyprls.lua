local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

lspconfig.hyprls.setup({
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
      pattern = { ".*/hypr/.*%.conf" },
      callback = function(event)
        vim.lsp.start {
          name = "hyprlang",
          cmd = {
            "hyprls"
          },
          root_dir = vim.fn.getcwd(),
        }
      end
    })
  end,
})
