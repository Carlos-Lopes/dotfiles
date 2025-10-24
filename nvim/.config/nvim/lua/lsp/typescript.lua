local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

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

vim.lsp.config("typescript-language-server", {
  init_options = { hostInfo = "neovim" },
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  capabilities = capabilities,
  root_dir = function(bufnr, on_dir)
    -- The project root is where the LSP can be started from
    -- As stated in the documentation above, this LSP supports monorepos and simple projects.
    -- We select then from the project root, which is identified by the presence of a package
    -- manager lock file.
    local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    on_dir(project_root)
  end,
  on_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)

    local function nmap(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "[LSP] " .. desc })
    end

    -- Enables `?^` to display the current type
    nmap("<leader>tt", "<cmd>TwoslashQueriesInspect<CR>", "Toggle Type")

    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, "source.")
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
          diagnostics = vim.diagnostic.get(bufnr),
        },
      })
    end, {})
  end,
  settings = {
    javascript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = inlayHints,
    },
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      inlayHints = inlayHints,
    },
  },
})

vim.lsp.enable("typescript-language-server")
