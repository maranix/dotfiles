return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'main',
        build = ':TSUpdate',

        config = function()
            local ts = require('nvim-treesitter')

            ts.install({
                'go',
                'dart',
                'python',
                'lua',
                "javascript",
                "typescript",
                "tsx",
                "jsx",
                "svelte",
                "html",
                "css"
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        opts = {},
        keys = {
            { "<leader>af", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
            end },
            { "<leader>if", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
            end },
            { "<leader>ac", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
            end },
            { "<leader>ic", function()
                require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
            end },
        },
    }
}
