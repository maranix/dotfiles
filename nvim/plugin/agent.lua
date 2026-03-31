vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim", name = "snacks" },
	{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
	{ src = "https://github.com/MunifTanjim/nui.nvim", name = "nui" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" },
	{ src = "https://github.com/yetone/avante.nvim", name = "avante" },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "Avante" },
	callback = function()
		require("render-markdown").setup({
			file_types = { "markdown", "Avante" },
		})
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	once = true,
	callback = function()
		require("avante").setup({
			instructions_file = "agent.md",
			provider = "gemini-cli",
			acp_providers = {
				["gemini-cli"] = {
					command = "gemini",
					args = { "--experimental-acp" },
					auth_method = "oauth-personal",
					env = {
						NODE_NO_WARNINGS = "1",
						HOME = os.getenv("HOME"),
						GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
						GEMINI_DEFAULT_AUTH_TYPE = "oauth-personal",
					},
				},
			},
		})
	end,
})
