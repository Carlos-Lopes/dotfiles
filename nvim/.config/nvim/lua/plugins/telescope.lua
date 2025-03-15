return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
  },
  config = function()
    local builtin = require("telescope.builtin")

    require("telescope").setup({
      defaults = {
        dynamic_preview_title = true,
        file_ignore_patterns = {
          [[ '.git', ]],
          'node_modules',
          'vendor',
        },
        path_display = {
          "smart"
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      }
    })

    -- Enable telescope fzf native, if installed
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")

    local function current_buffer_fuzzy_find()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end

    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    -- See `:help telescope.builtin`
    nmap("<leader>/", current_buffer_fuzzy_find, "[/] Fuzzily search in current buffer")
    nmap("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")
    nmap("<leader><space>", builtin.buffers, "[ ] Find existing buffers")
    nmap("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
    nmap("<leader>sf", builtin.find_files, "[S]earch [F]iles")
    nmap("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
    nmap("<leader>sw", builtin.grep_string, "[S]earch Current [W]ord")
  end,
}
