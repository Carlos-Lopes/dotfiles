local lspconfig = require("lspconfig")
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

local hints = {
  enumMemberValues = { enabled = true },
  functionLikeReturnTypes = { enabled = true },
  includeInlayEnumMemberValueHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  parameterNames = { enabled = "literals" },
  parameterTypes = { enabled = true },
  propertyDeclarationTypes = { enabled = true },
  variableTypes = { enabled = false },
}

-- Language server for Typescript
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Enables `?^` to display the current type
    require("twoslash-queries").attach(client, bufnr)

    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    nmap("<leader>tt", "<cmd>TwoslashQueriesInspect<CR>", '[T]oggle [T]ype')
  end,
  settings = {
    javascript = {
      updateImportsOnFileMove = {
        enabled = "always"
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = hints
    },
    typescript = {
      updateImportsOnFileMove = {
        enabled = "always"
      },
      suggest = {
        completeFunctionCalls = true,
      },
      inlayHints = hints
    },
  },
})
