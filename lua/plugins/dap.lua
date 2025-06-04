return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			-- Конфигурация для C++
			dap.adapters.codelldb = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = { "--port", "${port}" },
				},
			}
			dap.configurations.cpp = {
				{
					name = "Launch C++ (codelldb)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable file: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					console = "integratedTerminal",
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
		},
		event = "VeryLazy",
		config = function()
			local dapui = require("dapui")
			dapui.setup({
				layouts = {
					{
						elements = { "repl" },
						size = 0.1,
						position = "bottom",
					},
					{
						elements = { "breakpoints", "stacks", "watches" },
						size = 0.1,
						position = "left",
					},
					{
						elements = { "scopes" },
						size = 0.4, -- 40% от экрана
						position = "left",
					},
				},
			})

			-- Подписка на события DAP
			local dap = require("dap")
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb" },
				automatic_installation = true,
			})
		end,
	},
}
