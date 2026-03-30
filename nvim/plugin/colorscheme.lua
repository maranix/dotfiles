vim.pack.add({ {src = "https://github.com/wtfox/jellybeans.nvim", name = "jellybeans"} })

require("jellybeans").setup({
	background = {
		dark = 'jellybeans_muted',
		light = 'jellybeans_light',
	},
})

vim.cmd.colorscheme("jellybeans")
