return {
    { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },
    {
        'nvim-treesitter/nvim-treesitter-context',
        tag = 'v1.0.0',
        event = { 'BufRead', 'BufNewFile' },
        keys = {
            {
                '[c',
                function()
                    require('treesitter-context').go_to_context(vim.v.count1)
                end,
                desc = 'Go to context',
            },
        },
        opts = { max_lines = 1 },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'master',
        build = ':TSUpdate',
        opts = {
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        }
    },
}
