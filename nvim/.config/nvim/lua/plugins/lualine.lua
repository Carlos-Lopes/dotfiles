-- Neovim Status Line
-- https://github.com/nvim-lualine/lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local lualine = require('lualine')

    lualine.setup({
      options = {
        icons_enabled = vim.g.have_nerd_font,
        theme = 'catppuccin-mocha',
      },
    })
  end,
}
