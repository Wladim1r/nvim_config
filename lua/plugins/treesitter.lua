return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
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
          },
          sync_install = false,
          auto_isntall = true,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
 }
