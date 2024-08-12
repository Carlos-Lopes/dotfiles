-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Relative line numbers from the cursor
vim.opt.relativenumber = false -- TODO: MAKE IT TOGGLABLE
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣'
}

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Set colorscheme (order is important here)
vim.opt.termguicolors = true

-- Colorschemes that can be light or dark will be made dark
vim.opt.background = "dark"

-- Show sign column so that text doesn't shift
vim.opt.signcolumn = "yes"

-- Allow backspace on indent, end of line or insert mode start position
vim.opt.backspace = "indent,eol,start"

-- Set indentation as two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- vim.opt.softtabstop = 2
-- Expand Tab to use spaces
vim.opt.expandtab = true
-- Copy indent from previous line when starting new one
vim.opt.autoindent = true

-- Disable line wrapping
vim.opt.wrap = false

-- Set wrap guides
vim.opt.colorcolumn = '80,120'

-- Files and directories to ignore when navigating
-- vim.g.netrw_list_hide = '.bundle,.expo,.git,.idea,.vscode,node_modules,vendor'

-- Turn off swapfile
vim.opt.swapfile = false

-- Set Wrap Guides color
vim.api.nvim_set_hl(0, 'ColorColumn', { ctermbg = 'white', bg = 'white' })
-- Set background color as transparent
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
