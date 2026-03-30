local version = vim.version

local lsp_list = { lua_ls = {} }

vim.pack.add({
	-- Mason --
	{
		src = "https://github.com/mason-org/mason.nvim",
		name = "mason",
		version = version.range("2.x"),
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		name = "mason-lspconfig",
		version = version.range("2.x"),
	},
	-- Mason --

	--- Lsp Config --
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		name = "lspconfig",
		version = version.range("2.x"),
	},
	{
		src = "https://github.com/folke/lazydev.nvim",
		name = "lazydev",
		version = version.range("1.x"),
	},
	--- Lsp Config --

	-- Blink (completion, snippets etc) --
	{
		src = "https://github.com/saghen/blink.cmp",
		name = "blink",
		version = version.range("1.x"),
	},
	{ src = "https://github.com/rafamadriz/friendly-snippets", name = "friendly-snippets" },
	-- Blink --

	-- Formatter --
	{
		src = "https://github.com/stevearc/conform.nvim",
		name = "conform",
		version = version.range("9.x"),
	},
	-- Formatter --

	-- Diagnostic --
	{
		src = "https://github.com/folke/trouble.nvim",
		name = "trouble",
		version = "main",
	},
	-- Diagnostic --
})

local lsp_ready = false
local lua_ready = false
local formatter_ready = false

vim.schedule(function()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = vim.tbl_keys(lsp_list),
	})
end)

-- Lazy Load plugins that are not required on startup
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if lsp_ready then
			return
		end

		lsp_ready = true

		-- Trouble
		require("trouble").setup()
		vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

		-- Blink.cmp & nvim-lspconfig
		local blink = require("blink.cmp")

		local on_attach = function(_, bufnr)
			local opts = { noremap = true, silent = true, buf = bufnr }

			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)

			-- Diagnostic
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = 1 })
			end, opts)
		end

		for server, config in pairs(lsp_list) do
			config.capabilities = blink.get_lsp_capabilities(config.capabilities)
			config.on_attach = on_attach

			vim.lsp.config(server, config)
		end

		blink.setup({
			keymap = { preset = "enter" },
			signature = { enabled = true },
			completion = { list = { selection = { preselect = true, auto_insert = true } } },
			sources = {
				default = { "lazydev", "lsp", "snippets", "buffer", "path" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					snippets = {
						opts = {
							extended_filetypes = {
								javascript = { "jsdoc" },
								dart = { "flutter" },
							},
						},
					},
				},
			},
		})
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		if formatter_ready then
			return
		end

		local status, conform = pcall(require, "conform")
		if status then
			formatter_ready = true

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})

			conform.format({ bufnr = args.buf, lsp_format = "fallback" })
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		if lua_ready then
			return
		end

		local status, lazydev = pcall(require, "lazydev")
		if status then
			lua_ready = true

			lazydev.setup({
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			})
		end
	end,
})
