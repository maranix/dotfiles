return {
    {
        'saghen/blink.cmp',
        version = '1.*',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
            {
                'williamboman/mason.nvim',
                config = function()
                    require('mason').setup()

                    local uv = vim.uv

                    local lsps = {}
                    local path = uv.fs_scandir(vim.fn.stdpath('config') .. '/lsp')
                    if path then
                        while true do
                            local name, type = uv.fs_scandir_next(path)
                            if not name then
                                break
                            end

                            if type == 'file' then
                                local stripped_name = name:gsub('%..+$', '')
                                table.insert(lsps, stripped_name)
                            end
                        end
                    end

                    vim.diagnostic.config({
                        -- Use the default configuration
                        -- virtual_lines = true,

                        -- Alternatively, customize specific options
                        -- virtual_lines = {
                        --  -- Only show virtual line diagnostics for the current cursor line
                        --  current_line = true,
                        -- },

                        virtual_text = { current_line = true },
                    })

                    vim.lsp.enable(lsps)
                end,
            },
            {
                'folke/lazydev.nvim',
                ft = 'lua', -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                    },
                },
            },
        },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'enter' },

            completion = {
                list = {
                    selection = {
                        auto_insert = true,
                    },
                },

                documentation = { auto_show = false },

                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { 'kind_icon' }, { 'label', gap = 1 } },
                        components = {
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    local highlights_info = require('colorful-menu').blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        return highlights_info.label
                                    else
                                        return ctx.label
                                    end
                                end,

                                highlight = function(ctx)
                                    local highlights = {}
                                    local highlights_info = require('colorful-menu').blink_highlights(ctx)
                                    if highlights_info ~= nil then
                                        highlights = highlights_info.highlights
                                    end
                                    for _, idx in ipairs(ctx.label_matched_indices) do
                                        table.insert(highlights, {
                                            idx,
                                            idx + 1,
                                            group = 'BlinkCmpLabelMatch',
                                        })
                                    end

                                    -- Do something else
                                    return highlights
                                end,
                            },
                        },
                    },
                },
            },

            signature = {
                enabled = true,
                window = { border = 'rounded' },
            },

            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },

            fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
    },
}
