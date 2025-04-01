return {
    {
        'echasnovski/mini.nvim',
        tag = 'v0.15.0',
        keys = {
            { '<leader>ff', '<CMD>:Pick files<CR>', desc = 'Find files in CWD' },
            { '<leader>fb', '<CMD>:Pick buffers<CR>', desc = 'Find buffers' },
            { '<leader>fg', '<CMD>:Pick grep_live<CR>', desc = 'Live grep in CWD' },
        },

        config = function()
            require('mini.pick').setup()
            require('mini.surround')
        end,
    },
}
