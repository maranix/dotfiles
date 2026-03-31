vim.pack.add({
	{ src = "https://github.com/carlos-algms/agentic.nvim", name = "agentic" },
})

local loaded = false

local function setup_agentic()
	local agentic = require("agentic")

	if loaded then
		return agentic
	end

	agentic.setup({
		provider = "gemini-acp",
		debug = true,
	})
	loaded = true
	return agentic
end

vim.keymap.set({ "n", "v", "i" }, "<leader>aa", function()
	setup_agentic().toggle()
end, { desc = "Ask Agent" })

vim.keymap.set({ "n", "v" }, "<leader>ac", function()
	setup_agentic().add_selection_or_file_to_context()
end, { desc = "Add Context" })

vim.keymap.set("n", "<leader>an", function()
	setup_agentic().new_session()
end, { desc = "Agent New" })

vim.keymap.set("n", "<leader>ar", function()
	setup_agentic().restore_session()
end, { desc = "Agent Restore" })

vim.keymap.set("n", "<leader>ad", function()
	setup_agentic().add_current_line_diagnostics()
end, { desc = "Agent Diagnostics" })

vim.keymap.set("n", "<leader>ax", function()
	setup_agentic().add_buffer_diagnostics()
end, { desc = "Agent Buffer Diagnostics" })
