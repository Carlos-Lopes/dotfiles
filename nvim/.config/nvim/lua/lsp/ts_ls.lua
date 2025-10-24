local inlayHints = {
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

vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  settings = {
    javascript = {
      updateImportsOnFileMove = {        enabled = "always"      },
      suggest = {        completeFunctionCalls = true,      },
      inlayHints = inlayHints
    },
    typescript = {
      updateImportsOnFileMove = {        enabled = "always"      },
      suggest = {        completeFunctionCalls = true,      },
      inlayHints = inlayHints
    },
  },
  on_attach = function(client, bufnr)
    -- Enables `?^` to display the current type
    require("twoslash-queries").attach(client, bufnr)

    vim.keymap.set("n", "<leader>tt", { buffer = bufnr, desc = "<cmd>TwoslashQueriesInspect<CR>", '[T]oggle [T]ype' })
  end,
})

vim.lsp.enable('ts_ls')
