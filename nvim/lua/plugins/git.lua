return {
    {
        'tpope/vim-fugitive',
        commit = '4a745ea72fa93bb15dd077109afbb3d1809383f2',
        pin = true,
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
        tag = 'v1.0.2',
        pin = true,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            current_line_blame = true,
            attach_to_untracked = false,
        },
    },
}
