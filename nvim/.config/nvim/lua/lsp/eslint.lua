vim.lsp.config("eslint", {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
    "htmlangular",
  },
  workspace_required = true,
  root_markers = { ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", ".git" },
  -- on_attach = function(client, bufnr)
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = bufnr,
  --     command = "LspEslintFixAll",
  --   })
  -- end,
})

-- Enable ESLint LSP for matching buffers
-- vim.lsp.enable("eslint")
