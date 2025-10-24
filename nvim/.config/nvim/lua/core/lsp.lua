local keymap = vim.keymap
local severity = vim.diagnostic.severity
local telescope = require("telescope.builtin")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", {}),
  callback = function(event)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- Keymaps
    -- LSP Actions
    keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP: Code Action" }))
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename Symbol" }))

    -- LSP Navigation
    keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "LSP: Go to Declaration" }))
    keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to Definition" }))
    keymap.set("n", "gR", telescope.lsp_references, vim.tbl_extend("force", opts, { desc = "LSP: References" }))
    keymap.set("n", "gi", telescope.lsp_implementations, vim.tbl_extend("force", opts, { desc = "LSP: Implementations" }))
    keymap.set("n", "gt", telescope.lsp_type_definitions, vim.tbl_extend("force", opts, { desc = "LSP: Type Definitions" }))

    -- Symbols
    keymap.set("n", "<leader>ds", telescope.lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "LSP: Document Symbols" }))

    -- Diagnostics
    keymap.set("n", "<leader>D", function()
      telescope.diagnostics({ bufnr = 0 })
    end, vim.tbl_extend("force", opts, { desc = "LSP: Buffer Diagnostics" }))
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "LSP: Line Diagnostics" }))

    -- Toggle Inlay Hints (if supported)
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      keymap.set("n", "<leader>th", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
      end, vim.tbl_extend("force", opts, { desc = "LSP: Toggle Inlay Hints" }))
    end

    -- Highlight references of the word under the cursor when it rests there for a little while.
    if client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = group, buffer = ev.buf })
        end,
      })
    end

    -- Create a command `:Format` local to the LSP buffer
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format()
      end, { desc = "LSP: Format current buffer" })
    end
  end,
})

-- options for vim.diagnostic.config()
---@type vim.diagnostic.Opts
vim.diagnostic.config({
  float = {
    border = "rounded",
    source = "always",
    focusable = false,
  },
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "●",
  },
  severity_sort = true,
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN]  = " ",
      [severity.HINT]  = "󰠠 ",
      [severity.INFO]  = " ",
    },
  }
})

