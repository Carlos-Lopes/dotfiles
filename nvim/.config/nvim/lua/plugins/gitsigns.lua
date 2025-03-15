-- Git Decorations
-- https://github.com/lewis6991/gitsigns.nvim
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      current_line_blame = true,
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local nmap = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        nmap("<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle Git [B]lame")
      end
    })
  end
}
