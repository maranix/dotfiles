return {
    {
        'tpope/vim-fugitive',
        keys = function()
            return {
                { '<leader>gs', vim.cmd.Git, desc = 'Open Git' },
            }
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = {
            current_line_blame = true,
            attach_to_untracked = false,
        },
    },
}
