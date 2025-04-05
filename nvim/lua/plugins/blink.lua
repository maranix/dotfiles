return {
    {
        'folke/lazydev.nvim',
        tag = 'v1.9.0',
        ft = 'lua', -- only load on lua files
        pin = true,
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        event = { 'BufReadPre', 'BufNewFile' },
        version = '1.*',
        pin = true,
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'enter' },
            signature = { enabled = true },
            cmdline = { completion = { menu = { auto_show = true } } },
            completion = {
                list = { selection = { preselect = true, auto_insert = true } },
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

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
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
