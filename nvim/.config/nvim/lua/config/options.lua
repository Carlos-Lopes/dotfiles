-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Relative line numbers from the cursor
vim.opt.number = true
vim.opt.relativenumber = true

-- Set status, number and relativenumber column side-by-side
vim.o.statuscolumn = "%s %l %r "

-- Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣"
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set indentation as two spaces
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Expand Tab to use spaces
vim.opt.expandtab = true

-- Copy indent from previous line when starting new one
vim.opt.autoindent = true

-- Files and directories to ignore when navigating
vim.g.netrw_list_hide = ".bundle,.expo,.git,.idea,.vscode,node_modules,vendor"

-- Set wrap guides
vim.opt.colorcolumn = "80,120"

-- Set Wrap Guides color
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "white", bg = "white" })

-- Set background color as transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
