return {
	"mason-org/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},

	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local navic = require("nvim-navic")

		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end

		mason_lspconfig.setup({
			ensure_installed = {
				"gopls",
				"lua_ls",
				"clangd",
				"html",
				"cssls",
				"jsonls",
				"pyright",
			},
			automatic_installation = true,
			handlers = {
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						filetypes = { "go" },
						settings = {
							gopls = {
								analyses = {
									unusedparams = true,
									shadow = true,
									unusedwrite = true,
								},
								staticcheck = true,
								completeUnimported = true,
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								semanticTokens = false,
								codelenses = {
									generate = false,
									gc_details = false,
									test = true,
								},
							},
						},
						flags = {
							debounce_text_changes = 50,
						},
					})
				end,
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"clang-format",
				"prettier",
				"sql-formatter",
				"stylua",
				"black",
			},
		})
	end,
}
