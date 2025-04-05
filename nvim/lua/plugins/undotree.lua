local function get_path()
    if vim.uv.os_uname().sysname == 'Windows_NT' then
        return os.getenv('USERPROFILE') .. '/.vim/undodir'
    else
        return os.getenv('HOME') .. '/.vim/undodir'
    end
end

return {
    'mbbill/undotree',
    commit = 'b951b87b46c34356d44aa71886aecf9dd7f5788a',
    pin = true,
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
        {
            '<leader>u',
            '<CMD>UndotreeToggle<CR>',
            desc = 'Toggle Undotree',
        },
    },
    config = function()
        vim.opt.undodir = get_path()
        vim.opt.undofile = true
    end,
}
