return {
    { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },
    {
        'nvim-treesitter/nvim-treesitter-context',
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
        opts = { max_lines = 2 },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.3',
        pin = true,
        build = ':TSUpdate',
        event = { 'BufRead', 'BufNewFile' },
        config = function()
            local configs = require('nvim-treesitter.configs')

            ---@diagnostic disable-next-line: missing-fields
            configs.setup({
                auto_install = true,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
}
