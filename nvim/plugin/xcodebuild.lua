vim.pack.add({
	{ src = "https://github.com/wojciech-kulik/xcodebuild.nvim", name = "xcodebuild", version = "main" },
	{ src = "https://github.com/MunifTanjim/nui.nvim", name = "nui", version = "0.4.0" },
	{ src = "https://github.com/ibhagwan/fzf-lua", name = "fzf-lua", version = "main" },
})

vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" })

require("xcodebuild").setup({
	logs = {
		logs_formatter = nil,
	},
})
