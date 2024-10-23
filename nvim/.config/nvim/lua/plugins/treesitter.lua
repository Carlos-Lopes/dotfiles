-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-context"
  },
  build = ":TSUpdate",
  config = function()
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require("nvim-treesitter.install").prefer_git = true

    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "dart",
        "diff",
        "dockerfile",
        "go",
        "groovy",
        "html",
        "java",
        "javascript",
        "jq",
        "kotlin",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "objc",
        "pod",
        "query",
        "regex",
        "ruby",
        "rust",
        "sql",
        "swift",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig"
      },
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = {
          "ruby",
        },
      },
      indent = {
        enable = true,
        disable = {
          "ruby"
        }
      },
      sync_install = false
    })

    require("treesitter-context").setup({
      enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = "outer",     -- Which context lines to discard if `max_lines` is exceeded. Choices: "inner", "outer"
      mode = "topline",         -- Line used to calculate context. Choices: "cursor", "topline"
      -- Separator between context and content. Should be a single character string, like "-".
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20,     -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    })

    -- Tree-sitter based folding (implemented in Neovim itself, see :h vim.treesitter.foldexpr()).
    -- vim.wo.foldmethod = 'expr'
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
}
