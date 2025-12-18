return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'saghen/blink.cmp',
        {
            "j-hui/fidget.nvim",
            version = "*", -- alternatively, pin this to a specific version, e.g., "1.6.1"
            opts = {},
        },

        -- mason & mason-lspconfig
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                automatic_enable = false,
                ensure_installed = { "gopls", "basedpyright", "ruff", "ts_ls", "svelte", "zls" }
            },
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
            },
        }
    },
    -- using `opts` for defining servers
    opts = {
        servers = {
            gopls = {},
            ts_ls = {},
            svelte = {},
            zls = {},
            dartls = {},
            basedpyright = {
                -- Using Ruff's import organizer
                settings = {
                    basedpyright = {
                        disableOrganizeImports = true,
                    }
                }
            },
            ruff = {
                init_options = {
                    settings = {
                        lint = {
                            enable = false
                        }
                    }
                }
            },
        },
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', {}),
            callback = function(event)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- ─── LSP Essentials ──────────────────────────────────────────────
                map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
                map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
                map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
                map("n", "gr", vim.lsp.buf.references, "Goto References")
                map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
                map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")

                -- Simple code actions
                map({ "n", "v" }, "<leader>sca", vim.lsp.buf.code_action, "Code Action")

                -- Provider FuzzyFind-able version of code actions via fzf-lua
                map({ "n", "v" }, "<leader>ca", function()
                    require('fzf-lua').lsp_code_actions({ silent = true })
                end, "Code Action")


                -- ─── Workspace Management ───────────────────────────────────────
                map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
                map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
                map("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, "List Workspace Folders")

                -- ─── Diagnostics ────────────────────────────────────────────────
                map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
                map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

                -- Optional: type definition / symbol search
                map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
                map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Search Workspace Symbols")
                map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Search Document Symbols")
            end,
        })


        for server, config in pairs(opts.servers) do
            -- passing config.capabilities to blink.cmp merges with the capabilities in your
            -- `opts[server].capabilities, if you've defined it
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

            vim.lsp.config[server] = config
            vim.lsp.enable(server)
        end
    end
}
