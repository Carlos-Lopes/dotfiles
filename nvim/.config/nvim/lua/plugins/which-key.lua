return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    --
  },
  config = function ()
    require('which-key').setup()

    -- Document existing key chains
    -- require('which-key').register {
    --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    --   ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' },
    --   -- ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
    --   ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
    --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    --   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    --   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    --   ['<leader>T'] = { name = '[T]est', _ = 'which_key_ignore' },
    --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    -- }

    -- Visual Mode
    -- require('which-key').register({
    --   ['<leader>h'] = { 'Git [H]unk' },
    -- }, { mode = 'v' })
  end,
}
