return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				go = { "gofmt", "goimports", "golines" },
				json = { "prettier" },
				sql = { "sql-formatter" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--config-precedence", "prefer-file" },
					require_cwd_config = true,
				},
			},
			-- Форматировать при сохранении
			format_on_save = {
				timeout_ms = 100,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
	end,
}
