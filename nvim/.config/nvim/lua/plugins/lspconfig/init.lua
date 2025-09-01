return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
  },
  opts = {
    inlay_hints = {
      enabled = true
    },
  },
  config = function()
    require("plugins.lspconfig.configs.bashls")
    require("plugins.lspconfig.configs.eslint")
    require("plugins.lspconfig.configs.graphql")
    require("plugins.lspconfig.configs.jsonls")
    require("plugins.lspconfig.configs.html")
    require("plugins.lspconfig.configs.hyprls")
    require("plugins.lspconfig.configs.lua_ls")
    require("plugins.lspconfig.configs.rubocop")
    require("plugins.lspconfig.configs.ruby_lsp")
    require("plugins.lspconfig.configs.sourcekit")
    require("plugins.lspconfig.configs.ts_ls")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("core-lsp-attach", { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local nmap = function(keys, func, desc)
          local opts = {
            noremap = true,
            silent = true,
            buffer = bufnr,
            desc = "[LSP]: " .. desc
          }

          vim.keymap.set("n", keys, func, opts)
        end

        -- Keymaps
        -- Jump to the definition of the word under your cursor.
        nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        -- Find references for the word under your cursor.
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- Jump to the implementation of the word under your cursor.
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        -- Fuzzy find all the symbols in your current document.
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- Rename the variable under your cursor.
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        -- Execute a code action, usually your cursor needs to be on top of an error
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Highlight references of the word under the cursor when it rests there for a little while.
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("core-lsp-highlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          -- Clear highlights when LSP detaches
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("core-lsp-detach", { clear = true }),
            callback = function(ev)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "core-lsp-highlight", buffer = ev.buf })
            end,
          })
        end

        -- Toggle Inlay Hints if supported by the server
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          nmap("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end, "[T]oggle Inlay [H]ints")
        end

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(
          bufnr,
          "Format",
          function()
            vim.lsp.buf.format()
          end,
          { desc = "Format current buffer with LSP" }
        )
      end,
    })

    -- options for vim.diagnostic.config()
    ---@type vim.diagnostic.Opts
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
      },
      severity_sort = true,
    })
  end,
}
