return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  dependencies = {
    'nvim-lualine/lualine.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    {
      "<leader>dq",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Show [D]iagnostics",
    },
    {
      "<leader>ds",
      "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
      desc = "[LSP]: Show [D]efinitions [S]ymbols",
    },
  },
  config = function()
    require('trouble').setup({
      auto_close = true,
      restore = false
    })
  end
}
