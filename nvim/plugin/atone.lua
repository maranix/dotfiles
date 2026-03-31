vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/XXiaoA/atone.nvim", name = "atone" },
		})

		local atone = require("atone")
		atone.setup()

		vim.keymap.set("n", "<leader>u", function()
			vim.cmd.Atone("toggle")
		end, { desc = "Toggle Atone UI" })
	end,
})
