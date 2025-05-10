return {
    "mason-org/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

    config = function()

        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        require("mason").setup({
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
                "gopls",    -- Go
                "lua_ls",   -- Lua (если нужен)
            },
            automatic_installation = true,
        })

        mason_tool_installer.setup({
        ensure_installed = {
            "golines",  -- форматтер для Go
            "stylua",   -- форматтер для Lua (если нужен)
            },
        })
    end
}
