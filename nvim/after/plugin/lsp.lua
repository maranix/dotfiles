vim.schedule(function()
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
end)
