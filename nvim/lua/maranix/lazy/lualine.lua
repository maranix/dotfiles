return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require("lualine")

        -- start from current lualine config
        local cfg = lualine.get_config()
        cfg.sections = cfg.sections or {}
        cfg.sections.lualine_c = cfg.sections.lualine_c or {}

        -- Project-wide diagnostics (from lualine)
        table.insert(cfg.sections.lualine_c, 1, {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic" },
        })

        cfg.options = cfg.options or {}
        cfg.options.theme = "jellybeans"

        lualine.setup(cfg)
    end
}
