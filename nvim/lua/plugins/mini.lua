return {
    {
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            local surround = require('mini.surround')
            local pick = require('mini.pick')

            surround.setup()

            -- Mini.pick
            -- Files & Buffers
            vim.keymap.set('n', 'ff', '<CMD>:Pick files<CR>', { desc = 'Find files in CWD' })
            vim.keymap.set('n', 'fb', '<CMD>:Pick buffers<CR>', { desc = 'Find buffers' })

            -- Grep
            vim.keymap.set('n', 'fg', '<CMD>:Pick grep_live<CR>', { desc = 'Live grep in CWD' })
            -- Mini.pick

            pick.setup()
        end,
    },
}
