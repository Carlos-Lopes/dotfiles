-- Project Config
-- ~/.config/nvim
-- ├── lua
-- │   ├── config
-- │   │   ├── keymaps.lua - Keymap Config
-- │   │   ├── lazy.lua - lazy.nvim plugin manager
-- │   │   └── options.lua - NeoVim Config
-- │   └── plugins
-- │       └── <plugin>.lua
-- ├── init.lua
-- └── lazy-lock.json

require("config.lazy")
require("config.options")
require("config.keymaps")

-- [[ Configure plugins ]]
-- See https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
require("lazy").setup({
  spec = {
    { import = 'plugins' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {
    colorscheme = {
      "catppuccin-mocha"
    }
  },
  checker = {
    enabled = false
  },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
