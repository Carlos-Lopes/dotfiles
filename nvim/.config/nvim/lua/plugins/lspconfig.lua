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

    require("neoconf").setup({})

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

    -- Language server for Typescript
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
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
          inlayHints = {
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
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
          suggest = {
            completeFunctionCalls = true,
          },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayParameterNameHints = "literals",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            parameterNames = { enabled = "literals" },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
        },
      },
    })

    -- Kotlin language server.
    lspconfig.kotlin_language_server.setup({
      capabilities = capabilities,
    })

    -- Bash language server.
    lspconfig.bashls.setup({
      capabilities = capabilities
    })

    -- This gem is an implementation of the language server protocol specification for Ruby, used to improve editor features.
    -- Install the gem. There's no need to require it, since the server is used as a standalone executable.
    -- group :development do
    --   gem "ruby-lsp", require: false
    -- end
    -- lspconfig.ruby_lsp.setup({
    --   mason = false,
    --   cmd = { os.getenv("GEM_HOME") .. "/bin/ruby-lsp" },
    --   capabilities = capabilities,
    --   on_attach = function(client, buffer)
    --     vim.api.nvim_buf_create_user_command(buffer, "ShowRubyDeps", function(opts)
    --         local params = vim.lsp.util.make_text_document_params()
    --         local showAll = opts.args == "all"

    --         client.request("rubyLsp/workspace/dependencies", params, function(error, result)
    --           if error then
    --             print("Error showing deps: " .. error)
    --             return
    --           end

    --           local qf_list = {}
    --           for _, item in ipairs(result) do
    --             if showAll or item.dependency then
    --               table.insert(qf_list, {
    --                 text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
    --                 filename = item.path
    --               })
    --             end
    --           end

    --           vim.fn.setqflist(qf_list)
    --           vim.cmd('copen')
    --         end, buffer)
    --       end,
    --       { nargs = "?", complete = function() return { "all" } end })
    --   end,
    -- })

    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "ruby",
    --   callback = function()
    --     vim.lsp.start {
    --       name = "rubocop",
    --       cmd = { "bundle", "exec", "rubocop", "--lsp" },
    --     }
    --   end,
    -- })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("galleon-lsp-attach", { clear = true }),
      callback = function(event)
        local nmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "[LSP]: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
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

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        -- The following autocommand is used to enable inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          nmap("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
          end, "[T]oggle Inlay [H]ints")
        end

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(event.buf, "Format", function(_)
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
