-- Neovim Status Line
-- https://github.com/nvim-lualine/lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/trouble.nvim'
  },
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'catppuccin-mocha',
      },
      extensions = {
        'trouble'
      },
    })
  end,
}
