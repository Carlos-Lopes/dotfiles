-- Set <space> as the global leader key
vim.g.mapleader = " "

-- Set backslash as the local leader key
vim.g.maplocalleader = "\\"

-- Enable Nerd Font support (used for icons in plugins/UI)
vim.g.have_nerd_font = true

-- Customize the status column to show signs, line number, and relative number
vim.o.statuscolumn = "%s %3{v:lnum} %2{v:relnum} "

-- Show vertical color columns as visual wrap guides
vim.opt.colorcolumn = "80,120,160"

-- Highlight the line under the cursor
vim.opt.cursorline = true

-- Show the absolute line number for the current line
vim.opt.number = true

-- Show relative line numbers for other lines
vim.opt.relativenumber = true

-- Always show the sign column (e.g., for Git and diagnostics)
vim.opt.signcolumn = "yes"

-- Show whitespace characters like tabs and trailing spaces
-- See `:help 'list'` and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  trail = "·",
  nbsp = "␣"
}

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Don't display the mode (e.g. -- INSERT --) since it's shown in the status line
vim.opt.showmode = false

-- Sync system clipboard with Neovim
-- Scheduled after `UiEnter` for better startup time
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent (preserve indent on wrapped lines)
vim.opt.breakindent = true

-- Persist undo history to disk
vim.opt.undofile = true

-- Ignore case in search patterns...
vim.opt.ignorecase = true

-- ...unless uppercase letters or \C are used
vim.opt.smartcase = true

-- Reduce the time before triggering swap/autocommands (for better responsiveness)
vim.opt.updatetime = 250

-- Reduce timeout length for mapped sequences (e.g., for which-key)
vim.opt.timeoutlen = 300

-- Open vertical splits to the right
vim.opt.splitright = true

-- Open horizontal splits below
vim.opt.splitbelow = true

-- Live preview of :substitute commands
vim.opt.inccommand = "split"

-- Keep 8 lines of context above and below the cursor
vim.opt.scrolloff = 8

-- Enable automatic indentation
vim.opt.autoindent = true

-- Convert tabs to spaces
vim.opt.expandtab = true

-- Number of spaces to use for each indentation level
vim.opt.shiftwidth = 2

-- Number of spaces a tab feels like while editing
vim.opt.softtabstop = 2

-- Number of visual spaces per tab character
vim.opt.tabstop = 2

-- Ignore certain files and directories in netrw (file explorer)
vim.g.netrw_list_hide = [[.bundle,.expo,.git,.idea,.vscode,node_modules,vendor]]

-- Set the background color of Normal text to transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
