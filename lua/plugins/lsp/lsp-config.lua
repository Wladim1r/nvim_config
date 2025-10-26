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
		local navic = require("nvim-navic")
		-- diagnostic settings
		vim.diagnostic.config({
			underline = true,
			update_in_insert = true,
			virtual_text = {
				spacing = 4,
				prefix = "◈",
				source = "if_many",
				severity = { min = vim.diagnostic.severity.HINT },
			},
			severity_sort = true,
			float = {
				source = "if_many",
				border = "rounded",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
		})

		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#00ff00" })
		vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#00ff00" })

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
		
		
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-parameters", "unused-local" },
					},
					workspace = { checkThirdParty = false },
					completion = { callSnippet = "Replace" },
				},
			},
		})
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "c", "cpp", "h", "hpp" },
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
			},
		})
		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html" },
		})
		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "css", "scss", "less" },
		})
		-- JSON LSP
		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "json", "jsonc" },
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "python" },
		})
	end,
}
