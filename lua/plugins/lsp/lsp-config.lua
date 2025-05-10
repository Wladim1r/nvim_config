return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        -- Добавляем mason-lspconfig как зависимость
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local keymap = vim.keymap

        -- Настройка filetype для templ (если нужно)
        vim.filetype.add({ extension = { templ = "templ" } })

        -- Автокоманды для LSP (ваши keymaps остаются без изменений)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.diagnostic.config({
          -- Настройка значков для разных уровней диагностики
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              -- Остальные уровни не указываем, чтобы они не отображались
            },
          },
          
          -- Виртуальный текст (встроенные сообщения в коде)
          virtual_text = {
            prefix = "●",
            spacing = 4,
            format = function(diagnostic)
              return string.format(
                "%s (%s)",
                diagnostic.message,
                diagnostic.source or "unknown"
              )
            end,
            -- Показываем только ошибки
            severity = {
              min = vim.diagnostic.severity.ERROR,
              max = vim.diagnostic.severity.ERROR,
            },
          },
          
          -- Подчеркивание проблемных мест
          underline = {
            severity = {
              min = vim.diagnostic.severity.ERROR,
              max = vim.diagnostic.severity.ERROR,
            },
          },
          
          -- Обновление диагностики в режиме вставки
          update_in_insert = true,
          
          -- Сортировка по серьезности
          severity_sort = true,
          
          -- Дополнительные настройки для лучшего UX
          float = {
            border = "rounded",
            source = "always",
            header = "",
            prefix = function(diagnostic)
              -- Показываем иконку только для ошибок
              if diagnostic.severity == vim.diagnostic.severity.ERROR then
                return " "
              end
              return ""
            end,
            -- Фильтруем только ошибки для плавающего окна
            severity = {
              min = vim.diagnostic.severity.ERROR,
              max = vim.diagnostic.severity.ERROR,
            },
          },
        })
        lspconfig.templ.setup({
            capabilities = capabilities,
        })

        lspconfig.gopls.setup({
            capabilities = capabilities,
        })

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    completion = { callSnippet = "Replace" },
                },
            },
        })
    end,
}
