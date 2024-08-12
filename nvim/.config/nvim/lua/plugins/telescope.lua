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
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    {
      'nvim-tree/nvim-web-devicons',
      enabled = vim.g.have_nerd_font
    },
  },
  config = function()
    local builtin = require("telescope.builtin")

    require("telescope").setup({
      defaults = {
        dynamic_preview_title = true,
        file_ignore_patterns = {
          --[[ '.git', ]]
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
    require("telescope").load_extension('harpoon')
    require("telescope").load_extension("ui-select")

    local function current_buffer_fuzzy_find()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end

    local function find_files()
      builtin.find_files({ cwd = vim.fn.stdpath "config" })
    end

    -- See `:help telescope.builtin`
    vim.keymap.set("n", "<leader>/", current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sn", find_files, { desc = "[S]earch [N]eovim files" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch Current [W]ord" })
  end,
}
