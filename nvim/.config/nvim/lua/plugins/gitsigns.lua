-- Git Decorations
-- https://github.com/lewis6991/gitsigns.nvim
return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = {
        text = '+'
      },
      change = {
        text = '~'
      },
      delete = {
        text = '_'
      },
      topdelete = {
        text = '‾'
      },
      changedelete = {
        text = '~'
      },
    },
  },
  -- config = function()
  --   local gitsigns = require('gitsigns')

  --   vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk,
  --     { desc = "Preview [G]it [H]unks directly in the buffer (inline)" })
  --   vim.keymap.set("n", "<leader>gt", gitsigns.toggle_current_line_blame,
  --     { desc = "Toggle [G]it [B]lame for the current line" })
  -- end
}
