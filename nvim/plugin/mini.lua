vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini", version = "stable" },
})

local config = {
	diff = {
		view = {
			style = "sign",
			signs = { add = "+", change = "~", delete = "-" },
		},
	},
	pick = {
		options = {
			content_from_bottom = true,
		},
		window = {
			prompt_caret = "█",
			prompt_prefix = "   ", -- Nerd Font search icon
		},
	},
	split_join = {},
	comment = {},
	surround = {},
}

local setup_mini_tools = function()
	require("mini.diff").setup(config.diff)
	require("mini.splitjoin").setup(config.split_join)
	require("mini.surround").setup(config.surround)
	require("mini.comment").setup(config.comment)
end

vim.api.nvim_create_autocmd("BufReadPre", {
	once = true,
	callback = setup_mini_tools,
})

---------- Picker ----------
local pick = require("mini.pick")

vim.api.nvim_set_hl(0, "MiniPickBorder", { link = "MiniPickBorderBusy" })
vim.api.nvim_set_hl(0, "MiniPickBorderText", { link = "MiniPickBorderBusy" })
vim.api.nvim_set_hl(0, "MiniPickPromptCaret", { link = "MiniPickBorderBusy" })
vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { link = "MiniPickBorderBusy" })

pick.setup(config.pick)

vim.keymap.set("n", "<leader>ff", function()
	pick.builtin.files({ tool = "fd" })
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>gl", function()
	pick.builtin.grep_live({ tool = "rg" })
end, { desc = "Grep Live" })

vim.keymap.set("n", "<leader>fb", function()
	local wipeout_cur = function()
		vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, { force = true })
	end
	local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }

	pick.builtin.buffers({}, { mappings = buffer_mappings })
end, { desc = "Pick buffers" })
---------- Picker ----------
