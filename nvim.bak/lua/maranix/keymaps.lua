-- Open netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep the cursor in place while joining lines
vim.keymap.set('n', 'J', 'mzJ`z')

-- Scroll up & down inside the buffer while keeping the cursor in middle
vim.keymap.set('n', '<C-p>', '<C-d>zz')
vim.keymap.set('n', '<C-n>', '<C-u>zz')

-- Show search results while keeping the cursor in middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]]) -- Yank current line to system clipboard (`current` here refers to the line our cursor is currently on)
vim.keymap.set('n', '<leader>Y', [["+Y]])          -- Yanks highlighted line to system clipboard

-- next greatest remap ever : asbjornHaland
-- delete but don't copy
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- It just prevents keymaps from being executed when the key is pressed.
-- By setting <nop> to a key Q would prevent Q to trigger a keymap(normally it goes to the next search map).
vim.keymap.set('n', 'Q', '<nop>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move to next/previous QuickFix item
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')

-- Move to next/previous Location List item
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- Search & replace in the entire buffer
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file an executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')