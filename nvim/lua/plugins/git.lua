return {
    {
        'tpope/vim-fugitive',
        keys = function()
            return {
                { '<leader>gs', vim.cmd.Git, desc = 'open Git' },
                {
                    '<leader>p',
                    function()
                        vim.cmd.Git('push')
                    end,
                    desc = 'do git push',
                },
                {
                    '<leader>P',
                    function()
                        vim.cmd.Git('pull')
                    end,
                    desc = 'do git pull',
                },
                {
                    '<leader>PR',
                    function()
                        vim.cmd.Git({ 'pull', '--rebase' })
                    end,
                    desc = 'do git pull but rebase',
                },
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
