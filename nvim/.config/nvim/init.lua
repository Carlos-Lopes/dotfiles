-- Project Config
-- ~/.config/nvim
-- ├── lua
-- │   ├── core
-- │   │   ├── lazy.lua - Install lazy.nvim Plugin Manager
-- │   │   ├── defaults.lua - NeoVim General Config
-- │   │   └── keybinds.lua - Keymap Config for NeoVim
-- │   └── plugins
-- │       └── <plugin>.lua
-- ├── init.lua
-- └── lazy-lock.json

require("core.lazy")
require("core.defaults")
require("core.keybinds")

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
