local function get_path()
    if vim.uv.os_uname().sysname == 'Windows_NT' then
        return os.getenv('USERPROFILE') .. '/.vim/undodir'
    else
        return os.getenv('HOME') .. '/.vim/undodir'
    end
end

return {
    'mbbill/undotree',
    config = function()
        vim.opt.undodir = get_path()
        vim.opt.undofile = true
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
}
