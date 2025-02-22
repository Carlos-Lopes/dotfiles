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
          vim.keymap.set("n", keys, func, { noremap = true, silent = true, buffer = bufnr, desc = "[LSP]: " .. desc })
        end

        nmap("<leader>tb", function()
          gitsigns.toggle_current_line_blame()
        end, "[T]oggle Git [B]lame")

        nmap('<leader>tw', function()
          gitsigns.toggle_word_diff()
        end, "[T]oggle Git [W]ord Diff")
      end
    })
  end
}
