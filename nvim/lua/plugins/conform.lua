return {
    'stevearc/conform.nvim',
    tag = 'v9.0.0',
    pin = true,
    event = { 'LspAttach', 'BufWritePre', 'BufReadPost', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            '<leader>f',
            function()
                require('conform').format({ async = true, lsp_format = 'fallback' })
            end,
            mode = '',
            desc = 'Format buffer',
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { 'stylua' },
            zig = { 'zigfmt' },
            go = { 'gofmt' },
            python = { 'ruff_organize_imports', 'ruff_format' },

            -- This is so fucked
            javascript = { 'prettier_formatter' },
            javascriptreact = { 'prettier_formatter' },
            typescript = { 'prettier_formatter' },
            typescriptreact = { 'prettier_formatter' },
            vue = { 'prettier_formatter' },
            css = { 'prettier_formatter' },
            html = { 'prettier_formatter' },
        },
        formatters = {
            prettier_formatter = {
                command = 'prettier',
                args = { '--write', '--stdin-filepath', '$FILENAME' },
            },
        },
        -- Set default options
        default_format_opts = { lsp_format = 'fallback' },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = 'fallback',
        },
        -- Customize formatters
        --formatters = {
        --	shfmt = {
        --		prepend_args = { "-i", "2" },
        --	},
        --},
    },
    --init = function()
    --	-- If you want the formatexpr, here is the place to set it
    --	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    --end,
}
