return {
    'williamboman/mason.nvim',
    -- Lazy load
    cmd = 'Mason',
    tag = 'v1.11.0',
    pin = true,
    dependencies = {
        { 'williamboman/mason-lspconfig.nvim', tag = 'v1.32.0', pin = true },
        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            commit = '98767d37f8e5255a5111fc1e3163232d4dc07bda',
            pin = true,
        },
    },
    config = function()
        local mason = require('mason')

        vim.defer_fn(function()
            local mason_tool_installer = require('mason-tool-installer')
            local mason_registry = require('mason-registry')
            local mason_lspconfig = require('mason-lspconfig')

            local mappings = mason_lspconfig.get_mappings().lspconfig_to_mason
            local tooling = _G.lsp_tooling

            local ensure_installed = {}
            local skip_count = 0

            for i, v in ipairs(_G.lsp_list) do
                if mason_registry.has_package(mappings[v]) then
                    ensure_installed[i - skip_count] = v
                else
                    skip_count = skip_count + 1
                end
            end

            -- Concatenate both tooling & ensure_installed arrays
            table.move(tooling, 1, #tooling, #ensure_installed + 1, ensure_installed)

            mason_tool_installer.setup({
                ensure_installed = ensure_installed,
                integrations = {
                    ['mason-lspconfig'] = true,
                },
            })
            -- Execute installer
            vim.cmd('MasonToolsInstall')
        end, 1000)

        mason.setup()
    end,
}
