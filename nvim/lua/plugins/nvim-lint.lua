return {
    'mfussenegger/nvim-lint',
    commit = '93b8040115c9114dac1047311763bef275e752dc',
    pin = true,
    -- opts = {},
    config = function()
        -- Setup autocmd for Linting
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
            callback = function()
                local lint = require('lint')
                lint.try_lint()
            end,
        })
    end,
}
