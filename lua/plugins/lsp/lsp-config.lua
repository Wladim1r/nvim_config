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
		-- Настройка диагностики с приоритетом ошибок
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "E",
					[vim.diagnostic.severity.WARN] = "W",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
			},
			virtual_text = {
				severity = {
					min = vim.diagnostic.severity.WARN,
					severity_sort = true, -- Ошибки выше предупреждений
				},
				format = function(diagnostic)
					local prefixes = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
					}
					return (prefixes[diagnostic.severity] or "") .. diagnostic.message
				end,
			},
			underline = false,
			update_in_insert = true,
			severity_sort = true, -- Глобальная сортировка по важности
		})
		-- Единые настройки диагностики
		vim.diagnostic.config({
			virtual_text = {
				prefix = "◈",
				spacing = 1,
				severity_sort = true,
				format = function(diagnostic)
					local prefixes = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
					}
					return (prefixes[diagnostic.severity] or "") .. diagnostic.message
				end,
				severity = { min = vim.diagnostic.severity.WARN },
			},
			float = { border = "rounded" },
		})
		local capabilities = cmp_nvim_lsp.default_capabilities()
		local on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
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
		-- JavaScript/TypeScript LSP
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})
		-- ESLint LSP
		lspconfig.eslint.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
				-- Автоматически запускать ESLint при сохранении
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
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
	end,
}
