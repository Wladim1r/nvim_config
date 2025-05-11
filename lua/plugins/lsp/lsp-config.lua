return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Полностью отключаем подчеркивание
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = false })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = false })

        -- Единые настройки диагностики
        vim.diagnostic.config({
            virtual_text = {
                prefix = "◈",
                spacing = 2,
                format = function(diagnostic)
                    return diagnostic.message
                end,
                severity = { min = vim.diagnostic.severity.ERROR },
            },
            underline = false,
            update_in_insert = false, -- важно отключить!
            severity_sort = true,
            float = { border = "rounded" },
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Общий on_attach для всех LSP
        local on_attach = function(client, bufnr)
            -- Отключаем форматирование, если используем conform.nvim
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- Настройка gopls
        lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                gopls = {
                    analyses = { unusedparams = true },
                    staticcheck = true,
                    -- Важно: отключаем дублирующие проверки
                    gofumpt = false,
                }
            }
        })

        -- Настройка lua_ls
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                        disable = { "missing-parameters", "unused-local" }
                    },
                    workspace = { checkThirdParty = false },
                    completion = { callSnippet = "Replace" },
                }
            }
        })
    end
}
