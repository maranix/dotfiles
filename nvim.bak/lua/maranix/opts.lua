local opt = vim.opt

-- Disable mouse
opt.mouse = nil

-- Relative line numbers
opt.relativenumber = true

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Tab length
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Replace tabs with spaces
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

-- Disable Swap and Backup Files
opt.swapfile = false
opt.backup = false

-- Disable search highlighting.
opt.hlsearch = false
-- Enable incremental search.
opt.incsearch = true

-- Enable True Color Support
opt.termguicolors = true

-- Scroll Offset
-- Keeps 10 lines visible above and below the cursor while scrolling
opt.scrolloff = 10

opt.guicursor = ''

-- Enable absolute line numbering
opt.nu = true

-- Reserve space for diagnostic icons
opt.signcolumn = 'yes'

opt.updatetime = 50

-- Adds a vertical line at column 120.
opt.colorcolumn = '120'