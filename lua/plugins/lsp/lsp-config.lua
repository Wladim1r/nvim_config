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
			virtual_text = false,
			severity_sort = true,
			float = {
				source = "if_many",
				border = "rounded",
				header = "",
				format = function(d)
					return d.message
				end,
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "E",
					[vim.diagnostic.severity.WARN] = "W",
					[vim.diagnostic.severity.INFO] = "I",
					[vim.diagnostic.severity.HINT] = "H",
				},
			},
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()
		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
			if client.name ~= "gopls" then
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			else
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({
							filter = function(c)
								return c.name == "gopls"
							end,
							async = false,
						})
					end,
				})
			end
		end

		-- lspconfig.lua_ls.setup({
			-- capabilities = capabilities,
			-- on_attach = on_attach,
			-- settings = {
				-- Lua = {
					-- diagnostics = {
						-- globals = { "vim" },
						-- disable = { "missing-parameters", "unused-local" },
					-- },
					-- workspace = { checkThirdParty = false },
					-- completion = { callSnippet = "Replace" },
				-- },
			-- },
		-- })
		-- lspconfig.clangd.setup({
			-- capabilities = capabilities,
			-- on_attach = on_attach,
			-- filetypes = { "c", "cpp", "h", "hpp" },
			-- cmd = {
				-- "clangd",
				-- "--background-index",
				-- "--clang-tidy",
				-- "--header-insertion=never",
				-- "--completion-style=detailed",
				-- "--function-arg-placeholders",
				-- "--fallback-style=llvm",
			-- },
		-- })
		-- lspconfig.html.setup({
			-- capabilities = capabilities,
			-- on_attach = on_attach,
			-- filetypes = { "html" },
		-- })
		-- lspconfig.cssls.setup({
			-- capabilities = capabilities,
			-- on_attach = on_attach,
			-- filetypes = { "css", "scss", "less" },
		-- })
		-- JSON LSP
		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "json", "jsonc" },
			settings = {
				json = {
					-- schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						useLibraryCodeForTypes = false,
					},
				},
			},
		})
		-- DevOps: YAML, Dockerfile, docker compose, shell, Markdown
		lspconfig.yamlls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				-- не переставлять ключи при автодополнении
				yaml = { keyOrdering = false },
			},
		})
		lspconfig.dockerls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		-- сервер docker compose подключается только к типу yaml.docker-compose,
		-- а сам nvim даёт compose-файлам обычный тип yaml — учим его распознавать
		vim.filetype.add({
			filename = {
				["docker-compose.yml"] = "yaml.docker-compose",
				["docker-compose.yaml"] = "yaml.docker-compose",
				["compose.yml"] = "yaml.docker-compose",
				["compose.yaml"] = "yaml.docker-compose",
			},
			-- файлы переопределения: docker-compose.prod.yml, compose.local.yaml
			-- (косой черты в шаблоне быть не должно: иначе nvim сверяет его с полным путём)
			pattern = {
				["docker%-compose%.[%w_.-]+%.ya?ml"] = "yaml.docker-compose",
				["compose%.[%w_.-]+%.ya?ml"] = "yaml.docker-compose",
			},
		})
		lspconfig.docker_compose_language_service.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.marksman.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
