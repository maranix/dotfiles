return {
    {
        'WTFox/jellybeans.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            background = {
                dark = 'jellybeans_muted',
                light = 'jellybeans_light',
            },
        },
        config = function(opts)
            require('jellybeans').setup(opts)

            vim.cmd.colorscheme('jellybeans')
        end
    },
}