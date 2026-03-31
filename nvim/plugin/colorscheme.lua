vim.pack.add({
	{ src = "https://github.com/wtfox/jellybeans.nvim", name = "jellybeans" },
	{ src = "https://github.com/ribru17/bamboo.nvim", name = "bamboo" },
})

local clsm = "bamboo"

require(clsm).setup()

vim.cmd.colorscheme(clsm)
