return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
		},
		keys = {
			{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
			{ "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step Over" },
			{ "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step Out" },
			{ "<leader>dt", "<cmd>DapTerminate<cr>", desc = "Terminate" },
		},
		config = function()
			local dap = require("dap")

			-- Логирование
			dap.set_log_level("TRACE")

			-- Конфигурация адаптера для Go
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv", -- или полный путь: vim.fn.exepath("dlv")
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- Конфигурации для Go
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug Package",
					request = "launch",
					program = "${fileDirname}",
				},
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = true,
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
			})

			-- Автоматическое открытие/закрытие UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			ensure_installed = { "delve" },
			automatic_installation = true,
			handlers = {},
		},
	},
}
