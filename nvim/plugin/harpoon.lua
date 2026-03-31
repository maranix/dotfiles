local loaded = false

local load_harpoon = function()
	local harpoon = require("harpoon")

	if not loaded then
		harpoon:setup()
		loaded = true
	end

	return harpoon
end

vim.schedule(function()
	vim.pack.add({
		{ src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
		{
			src = "https://github.com/ThePrimeagen/harpoon",
			name = "harpoon",
			version = "harpoon2",
		},
	})

	vim.keymap.set("n", "<leader>a", function()
		local harpoon = load_harpoon()
		harpoon:list():add()
	end, { desc = "Harpoon Add" })

	vim.keymap.set("n", "<C-e>", function()
		local harpoon = load_harpoon()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Harpoon Menu" })

	-- Navigation
	vim.keymap.set("n", "<C-h>", function()
		local harpoon = load_harpoon()
		harpoon:list():select(1)
	end)

	vim.keymap.set("n", "<C-j>", function()
		local harpoon = load_harpoon()
		harpoon:list():select(2)
	end)

	vim.keymap.set("n", "<C-k>", function()
		local harpoon = load_harpoon()
		harpoon:list():select(3)
	end)

	vim.keymap.set("n", "<C-l>", function()
		local harpoon = load_harpoon()
		harpoon:list():select(4)
	end)
end)
