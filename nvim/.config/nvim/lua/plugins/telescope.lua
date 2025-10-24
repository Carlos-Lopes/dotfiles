return {
  'nvim-telescope/telescope.nvim',
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
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    "folke/todo-comments.nvim",
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

    local opts = { buffer = bufnr }

    -- See `:help telescope.builtin`
    vim.keymap.set("n", "<leader>/", current_buffer_fuzzy_find, vim.tbl_extend("force", opts, { desc = "[/] Fuzzily search in current buffer" }))
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, vim.tbl_extend("force", opts, { desc = "[ ] Find existing buffers" }))
    vim.keymap.set("n", "<leader><space>", builtin.buffers, vim.tbl_extend("force", opts, { desc = "[ ] Find existing buffers" }))
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, vim.tbl_extend("force", opts, { desc = "[S]earch [D]iagnostics" }))
    vim.keymap.set("n", "<leader>sf", builtin.find_files, vim.tbl_extend("force", opts, { desc = "[S]earch [F]iles" }))
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, vim.tbl_extend("force", opts, { desc = "[S]earch by [G]rep" }))
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, vim.tbl_extend("force", opts, { desc = "[S]earch Current [W]ord" }))
  end,
}
