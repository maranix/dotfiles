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

              sections = { "error", "warn" },

              symbols = {
                error = "E ",
                warn  = "W ",
              },

              diagnostics_color = {
                  error = { fg = "#c97b7b" },
                  warn  = { fg = "#c9b97b" },
              },

              colored = true,
              update_in_insert = false,
              always_visible = false,

              -- subtle separator so it reads as a group
              separator = "│",
        })

        lualine.setup(cfg)
    end
}
