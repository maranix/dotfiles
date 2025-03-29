local opt = vim.opt

-- Relative line numbers
opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Tab length
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Replace tabs with spaces
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- Disable Swap and Backup Files
vim.opt.swapfile = false
vim.opt.backup = false

-- Disable search highlighting.
vim.opt.hlsearch = false
-- Enable incremental search.
vim.opt.incsearch = true

-- Enable True Color Support
vim.opt.termguicolors = true

-- Scroll Offset
-- Keeps 10 lines visible above and below the cursor while scrolling
vim.opt.scrolloff = 10

vim.opt.guicursor = ''

-- Enable absolute line numbering
vim.opt.nu = true

-- Reserve space for diagnostic icons
vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 50

-- Adds a vertical line at column 120.
vim.opt.colorcolumn = '120'
