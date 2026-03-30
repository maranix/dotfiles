vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
})

local lualine = require("lualine")

-- start from current lualine config
local cfg = lualine.get_config()
cfg.sections = cfg.sections or {}

table.remove(cfg.sections.lualine_b, 3) -- Remove buffer 'diagnostics', since we are showing workspace

cfg.sections.lualine_c = cfg.sections.lualine_c or {}

-- Project-wide diagnostics (from lualine)
table.insert(cfg.sections.lualine_c, 1, {
	"diagnostics",
	sources = { "nvim_workspace_diagnostic" },
	sections = { "error", "warn" },
	symbols = {
		error = "E ",
		warn = "W ",
	},
	diagnostics_color = {
		error = { fg = "#c97b7b" },
		warn = { fg = "#c9b97b" },
	},
	colored = true,
	update_in_insert = false,
	always_visible = false,

	-- subtle separator so it reads as a group
	separator = "│",
})

lualine.setup(cfg)
