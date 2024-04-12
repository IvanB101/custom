local plugins = {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = false,
    },
    {
        "mbbill/undotree",
        lazy = false,
    },
    {
        "folke/trouble.nvim",
        lazy = false,
    },
    {
        'nvim-pack/nvim-spectre',
        lazy = false,
    },
    {
        'mfussenegger/nvim-jdtls',
    },
    {
        'lervag/vimtex',
        lazy = false,
        -- init = function ()
        --     require("custom.config.vimtex")
        -- end,
    },
    {
        "L3MON4D3/LuaSnip",
        opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
        },
        config = function(_, opts)
            require("plugins.configs.others").luasnip(opts)
            require("custom.configs.luasnip")
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require "custom.configs.null-ls"
            end,
        },
    },
    {
        "williamboman/mason.nvim",
        opts = require("custom.configs.mason"),
    },
    {
        "rust-lang/rust.vim",
        ft = "rust",
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    -- {
    --     "simrat39/rust-tools.nvim",
    --     ft = "rust",
    --     dependencies = "neovim/nvim-lspconfig",
    --     ops = require("custom.configs.rust-tools"),
    --     config = function (_, opts)
    --         require("rust-tools").setup(opts)
    --     end
    -- },
    -- {
    --     -- sudo apt install lldb
    --     "mfussenegger/nvim-dap"
    -- },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        dependencies = "hrsg7th/nvim-cmp",
        config = function(_, opts)
            local crates = require("crates")
            crates.setup(opts)
            crates.show()
        end
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function()
            local M = require("plugins.configs.cmp")
            table.insert(M.sources, { name = "crates" })
            return M
        end
    }
}

return plugins
