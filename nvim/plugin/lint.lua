vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-lint", name = "nvim-lint", version = "master" },
})

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
	group = lint_augroup,
	callback = function()
		if not vim.endswith(vim.fn.bufname(), "swiftinterface") then
			require("lint").try_lint()
		end
	end,
})

require("lint").linters_by_ft = {
	swift = { "swiftlint" },
}
