return {
    { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            vim.keymap.set('n', '[c', function()
                require('treesitter-context').go_to_context(vim.v.count1)
            end, { silent = true })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
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
