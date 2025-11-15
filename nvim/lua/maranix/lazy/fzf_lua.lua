return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        files = {
            previewer = false
        }
    },
    keys = {
        -- Files --
        { "<leader>ff", "<cmd>FzfLua files<cr>",        desc = "Find Files" },

        -- Buffers --
        { "<leader>fb", "<cmd>FzfLua buffers<cr>",        desc = "Find Buffers" },

        -- Grep --
        { "<leader>gb", "<cmd>FzfLua grep_curbuf<cr>",  desc = "Live Grep Current Buffer" },
        { "<leader>gp", "<cmd>FzfLua grep_project<cr>", desc = "Live Grep Project" },

        -- QuickFix --
        { "<leader>qf", "<cmd>FzfLua quickfix<cr>",     desc = "Find In Quick Fix List" },

        -- Resume --
        { "<leader>fr", "<cmd>FzfLua resume<cr>",     desc = "Find In Quick Fix List" },
    },
}
