require("config")

-- [[ Configure plugins ]]
-- See https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
require("lazy").setup({
  spec = {
    { import = 'plugins' },
  },
  checker = { enabled = true },
})
