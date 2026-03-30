vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.nvim", name = "mini", version = "stable" },
})

local loaded = {
	notify = false,
	diff = false,
	split_join = false,
	comment = false,
	surround = false,
}

local config = {
	notify = {
		content = {
			format = function(notif)
				return notif.msg
			end,
		},
		window = {
			config = {
				anchor = "SE",
				border = "rounded",
				col = vim.o.columns,
				row = vim.o.lines - 3, -- Show one row above Statusline
			},
		},
	},
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

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if not loaded.notify then
			local status, notify = pcall(require, "mini.notify")
			if status then
				notify.setup(config.notify)

				vim.notify = notify.make_notify()
				loaded.notify = true
			end
		end

		if not loaded.diff then
			local status, diff = pcall(require, "mini.diff")
			if status then
				diff.setup(config.diff)
				loaded.diff = true
			end
		end

		if not loaded.split_join then
			local status, split_join = pcall(require, "mini.splitjoin")
			if status then
				split_join.setup(config.split_join)
				loaded.split_join = true
			end
		end

		if not loaded.surround then
			local status, surround = pcall(require, "mini.surround")
			if status then
				surround.setup(config.surround)
				loaded.surround = true
			end
		end

		if not loaded.comment then
			local status, comment = pcall(require, "mini.comment")
			if status then
				comment.setup(config.comment)
				loaded.comment = true
			end
		end
	end,
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
		vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, {})
	end
	local buffer_mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } }

	pick.builtin.buffers({}, { mappings = buffer_mappings })
end, { desc = "Pick buffers" })
---------- Picker ----------
