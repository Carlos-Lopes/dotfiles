return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "j-hui/fidget.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
    "b0o/schemastore.nvim",
    "folke/neoconf.nvim"
  },
  opts = {
    inlay_hints = {
      enabled = true
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    require("neoconf").setup({
      --
    })

    -- Lua language server.
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
          },
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {
              "vim",
              "require",
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- Language server for Swift and C/C++/Objective-C.
    -- https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
    lspconfig.sourcekit.setup({
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      },
    })

    -- Linting engine for JavaScript/Typescript.
    lspconfig.eslint.setup({
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })

    -- Language server for JSON and JSON schema.
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })

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

    -- Language server for Typescript
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- Enables `?^` to display the current type
        require("twoslash-queries").attach(client, bufnr)
      end,
      settings = {
        javascript = {
          updateImportsOnFileMove = {
            enabled = "always"
          },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = inlayHints
        },
        typescript = {
          updateImportsOnFileMove = {
            enabled = "always"
          },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = inlayHints
        },
      },
    })

    -- Bash language server.
    lspconfig.bashls.setup({
      capabilities = capabilities
    })

    -- GraphQL
    lspconfig.graphql.setup({})

    -- Ruby
    lspconfig.ruby_lsp.setup({
      capabilities = capabilities,
      cmd = { vim.fn.expand("~/.rbenv/versions/3.2.2/bin/ruby-lsp") },
      init_options = {
        formatter = 'standard',
        linters = { 'standard' },
      },
    })

    -- Rubocop
    lspconfig.rubocop.setup({
      cmd = { vim.fn.expand("~/.rbenv/versions/3.2.2/bin/rubocop"), "--lsp" },
      on_attach = function(_, bufnr)
        -- Format the code on buffer write
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format()
          end,
        })
      end
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("galleon-lsp-attach", { clear = true }),
      callback = function(event)
        local bufnr = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local nmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = "[LSP]: " .. desc })
        end

        -- LSP KEYMAPS
        -- Jump to the definition of the word under your cursor.
        nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        -- Find references for the word under your cursor.
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        -- Jump to the implementation of the word under your cursor.
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        -- Jump to the type of the word under your cursor.
        nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        -- Fuzzy find all the symbols in your current document.
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        -- Fuzzy find all the symbols in your current workspace.
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        -- Rename the variable under your cursor.
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        -- Execute a code action, usually your cursor needs to be on top of an error
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        -- Opens a popup that displays documentation about the word under your cursor
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        -- Lesser used LSP functionality
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- Highlight references of the word under the cursor when it rests there for a little while.
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          -- Clear highlights when LSP detaches
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
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
        vim.api.nvim_buf_create_user_command(event.buf, "Format", function()
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })
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

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { 'Fastfile', 'Appfile', 'Matchfile', 'Pluginfile', 'Podfile' },
      callback = function()
        vim.o.filetype = "ruby"
      end,
    })
  end,
}
