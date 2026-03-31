vim.pack.add({
	{ src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
})

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local lualine = require("lualine")

		-- start from current lualine config
		local cfg = lualine.get_config()
		cfg.sections = cfg.sections or {}

		-- Remove buffer 'diagnostics', since we are showing workspace
		if cfg.sections.lualine_b and #cfg.sections.lualine_b >= 3 then
			table.remove(cfg.sections.lualine_b, 3)
		end

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
	end,
})
