local mod_cache = nil

local server = {
    default_config = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = function(fname)
            -- see: https://github.com/neovim/nvim-lspconfig/issues/804
            if not mod_cache then
                mod_cache = vim.fn.system('go env GOMODCACHE')
            end
            if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
                local clients = vim.lsp.get_clients({ name = 'gopls' })
                if #clients > 0 then
                    return clients[#clients].config.root_dir
                end
            end
            return { 'go.work', 'go.mod', '.git', fname }
        end,
        single_file_support = true,
    },
    docs = {
        description = [[
https://github.com/golang/tools/tree/master/gopls

Google's lsp server for golang.
]],
    },
}

return server.default_config
