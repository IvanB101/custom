local plugins = {
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "vim-crystal/vim-crystal",
        ft = "crystal",
        config = function(_)
            vim.g.crystal_auto_format = 1
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
        "williamboman/nvim-lsp-installer",
        lazy = false,
        opts = require("custom.configs.lsp_installer")
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
}
return plugins
