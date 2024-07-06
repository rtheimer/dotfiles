return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig",
        "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- import mason
        local mason = require("mason")
        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        -- Import lspconfig plugin
        local lspconfig = require("lspconfig")
        -- Define capabilities and on_attach
        --local capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities =require('cmp_nvim_lsp').default_capabilities()
        local on_attach = function(client, bufnr)
            print('LSP client: ' .. client.name .. ' attached to buffer ' .. bufnr)
        end
        -- enable mason and configure icon
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "pyright",
                "html",
                "lua_ls",
                "tsserver",
                "emmet_language_server",
                "clangd",
                "tailwindcss",
            },
            -- auto install configured servers
            automatic_installation = true,
        })
        -- Setup language servers
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "workspace", -- openFilesOnly, workspace
                        typeCheckingMode = "off", -- off, basic, strict
                        useLibraryCodeForTypes = true,
                        --diagnosticMode = "off"
                    }
                }
            }
        })

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = { globals = {'vim'} },
                    runtime = {
                        version = 'Lua 5.3',
                        path = {
                            '?.lua',
                            '?/init.lua',
                            vim.fn.expand'~/.luarocks/share/lua/5.3/?.lua',
                            vim.fn.expand'~/.luarocks/share/lua/5.3/?/init.lua',
                            '/usr/share/5.3/?.lua',
                            '/usr/share/lua/5.3/?/init.lua'
                        }
                    },
                    workspace = {
                        library = {
                            vim.fn.expand'~/.luarocks/share/lua/5.3',
                            '/usr/share/lua/5.3'
                        }
                    }
                }
            }
        })
        lspconfig.tsserver.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                filetypes = {"typescript", "typescriptreact", "typescript.tsx"}
            },
        })
        lspconfig.html.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.emmet_language_server.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.clangd.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {'c', 'cpp', 'cxx', 'cc'},
        })
        lspconfig.tailwindcss.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
