local builtin = require("telescope.builtin")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspAttachGroup", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local function nmap(keys, func, desc)
      local opts = {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = "[LSP]: " .. desc,
      }

      vim.keymap.set("n", keys, func, opts)
    end

    -- Keymaps
    -- LSP Actions
    nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")

    -- LSP Navigation
    nmap("gD", vim.lsp.buf.declaration, "Open Declaration")
    nmap("gd", vim.lsp.buf.definition, "Open Definition")
    nmap("gR", builtin.lsp_references, "References")
    nmap("gi", builtin.lsp_implementations, "Implementations")
    nmap("gt", builtin.lsp_type_definitions, "Type Definitions")

    -- Symbols
    nmap("<leader>ds", builtin.lsp_document_symbols, "Document Symbols")

    -- Diagnostics
    nmap("<leader>D", function()
      builtin.diagnostics({ bufnr = 0 })
    end, "Buffer Diagnostics")
    nmap("<leader>d", vim.diagnostic.open_float, "Line Diagnostics")

    if not client or not client.server_capabilities then
      return
    end

    -- Toggle Inlay Hints (if supported)
    if client.server_capabilities.inlayHintProvider then
      nmap("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, "Toggle Inlay Hints")
    end

    -- Highlight references of the word under the cursor when it rests there for a little while.
    if client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup("LspHighlightGroup", { clear = false })

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
        group = vim.api.nvim_create_augroup("LspDetachGroup", { clear = true }),
        callback = function()
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
        end,
      })
    end

    -- Create a command `:Format` local to the LSP buffer
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "LSP: Format current buffer" })
    end
  end,
})

vim.diagnostic.config({
  float = {
    border = "rounded",
    source = true,
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
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
    },
  }
})
