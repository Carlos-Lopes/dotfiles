-- Use Nerd Font icons in plugins
vim.g.have_nerd_font = true

-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Ignore these directories or files in netrw
vim.g.netrw_list_hide = [[.bundle,.expo,.git,.idea,.vscode,node_modules,vendor]]

-- UI
-- Show line and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = "%s %3{v:lnum} %2{v:relnum} "

-- Highlight the current line
vim.opt.cursorline = true

-- Always show the sign column
vim.opt.signcolumn = "yes"

-- Show ruler at 120 chars
vim.opt.colorcolumn = "120"

-- Show invisible characters
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣"
}

-- Don’t show mode (use statusline instead)
vim.opt.showmode = false

-- Indentation & Tabs
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Configure 1 tab into 2 spaces
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Editing Behavior
-- Show effects of commands incrementally
vim.opt.inccommand = "split"

-- Keep 8 lines visible when scrolling
vim.opt.scrolloff = 8

-- Configure Horizontal splits below and Vertical splits to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.mouse = "a"

-- Faster keymap timeout and CursorHold events
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

-- Persistent undo history
vim.opt.undofile = true

-- Performance & Misc
-- Better colors
vim.opt.termguicolors = true
-- Faster macros/redraws
vim.opt.lazyredraw = true
-- Use system clipboard for all operations
vim.opt.clipboard = "unnamedplus"

-- Remove background for the Normal highlight group
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
