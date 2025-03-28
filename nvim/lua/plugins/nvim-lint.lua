-- Setup autocmd for Linting
vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' }, {
    callback = function()
        local lint = require('lint')
        lint.try_lint()
    end,
})

return {
    'mfussenegger/nvim-lint',
    -- opts = { },
}
