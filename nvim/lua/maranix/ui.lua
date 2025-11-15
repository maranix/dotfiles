local o = vim.o

-- Add borders around Windows
o.winborder = 'rounded'

vim.diagnostic.config({
    -- Use the default configuration
    -- virtual_lines = true,
    --
    -- Alternatively, customize specific options
    -- virtual_lines = {
    -- -- Only show virtual line diagnostics for the current cursor line
    --  current_line = true,
    -- },

    virtual_text = { current_line = true },
})