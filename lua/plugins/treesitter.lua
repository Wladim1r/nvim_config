return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"lua",
				"go",
				"sql",
				"make",
				"dockerfile",
				"yaml",
				"proto",
				"cpp",
				"clangd",
				"clang-format",
				"codelldb",
				"html",
				"css",
				"scss",
				-- JavaScript/TypeScript
				"javascript",
				"typescript",
				"tsx",
				"json",
				"jsonc",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true, additional_vim_regex_highlighting = false },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn",
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
			-- Отключаем дублирующие функции LSP
			textobjects = {
				select = {
					enable = false, -- Важно отключить, если используете LSP
				},
			},
		})
	end,
}
