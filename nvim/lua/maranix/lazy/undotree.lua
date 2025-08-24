return {
    'mbbill/undotree',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
        {
            '<leader>u',
            '<CMD>UndotreeToggle<CR>',
            desc = 'Toggle Undotree',
        },
    },
    config = function()
        local dir

        if vim.uv.os_uname().sysname == 'Windows_NT' then
            dir = os.getenv('USERPROFILE') .. '/.vim/undodir'
        else
            dir = os.getenv('HOME') .. '/.vim/undodir'
        end

        vim.opt.undodir = dir
        vim.opt.undofile = true
    end,
}
