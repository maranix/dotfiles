return {
    'stevearc/oil.nvim',
    tag = 'v2.15.0',
    keys = {
        { '<leader>pv', '<CMD>Oil --float<CR>', desc = 'Open Oil.nvim in floating window ' },
    },
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = { default_file_explorer = false },
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
}
