local uv = vim.loop

local lsps = {}
local path = uv.fs_scandir(vim.fn.stdpath('config') .. '/lsp')
if path then
    while true do
        local name, type = uv.fs_scandir_next(path)
        if not name then
            break
        end

        if type == 'file' then
            local stripped_name = name:gsub('%..+$', '')
            table.insert(lsps, stripped_name)
        end
    end
end

return {
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'saghen/blink.cmp',
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = lsps,
            })

            local capabilities = require('blink.cmp').get_lsp_capabilities({}, false)

            vim.lsp.config('*', { capabilities = capabilities })
            vim.lsp.enable(lsps)
        end,
    },
}
