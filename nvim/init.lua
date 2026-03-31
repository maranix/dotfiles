vim.loader.enable()

local g = vim.g
local o = vim.o
local opt = vim.opt

---------- UI ----------
o.winborder = "rounded"
vim.diagnostic.config({
	virtual_text = true,
})
---------- UI ----------

---------- Keymaps ----------
g.mapleader = vim.keycode("<space>")
g.maplocalleader = "\\"

-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep the cursor in place while joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll up & down inside the buffer while keeping the cursor in middle
vim.keymap.set("n", "<C-p>", "<C-d>zz")
vim.keymap.set("n", "<C-n>", "<C-u>zz")

-- Show search results while keeping the cursor in middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Yank current line to system clipboard (`current` here refers to the line our cursor is currently on)
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- Yanks highlighted line to system clipboard

-- next greatest remap ever : asbjornHaland
-- delete but don't copy
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Search & replace in the entire buffer
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
---------- Keymaps ----------

---------- Opt ----------

opt.mouse = nil -- Disable mouse
opt.relativenumber = true -- Relative line numbers
opt.showmode = false -- Don't show the mode
opt.inccommand = "split" -- preview substitutions live

-- Tab length
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true -- Replace tabs with spaces

opt.ignorecase = true -- Case insensitive search
opt.smartcase = true -- Case sensitive if uppercase in search
opt.hlsearch = false -- Disable search highlighting.
opt.incsearch = true -- Enable incremental search.

opt.termguicolors = true -- Enable True Color Support
opt.nu = true -- Enable absolute line numbering
opt.signcolumn = "yes" -- Reserve space for diagnostic icons
opt.colorcolumn = "120" -- Adds a vertical line at column 120.
opt.cursorline = true -- Highlight current line
opt.scrolloff = 10 -- Keep 10 lines above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor

opt.guicursor = ""
opt.smartindent = true
opt.wrap = false

opt.synmaxcol = 300 -- Syntax highlighting limit
opt.updatetime = 300 -- Faster completion
opt.redrawtime = 10000
opt.maxmempattern = 20000

opt.backup = false -- Don't create backup files
opt.writebackup = false -- Don't create backup before writing
opt.swapfile = false -- Don't create swap files
opt.undofile = true -- Persistent undo
---------- Opt ----------
