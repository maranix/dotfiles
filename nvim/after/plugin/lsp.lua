local uv = vim.uv
local path = uv.fs_scandir(vim.fn.stdpath('config') .. '/lsp')

local lsps = {}

if path then
    local name, type
    repeat
        name, type = uv.fs_scandir_next(path)
        if type == 'file' and name then
            -- Strip extension only if necessary
            local stripped_name = name:match('^(.*)%.')
            lsps[#lsps + 1] = stripped_name or name
        end
    until not name
end

-- Contains all the configured lsps from ~/.config/nvim/lsp/*
_G.lsp_list = lsps
_G.lsp_tooling = { 'prettier', 'stylua' }

-- Configure LSPs
vim.lsp.enable(lsps)

-- Override default LSP keybindings via autocmd
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Lsp Keybindings',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>rf', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end,
})
