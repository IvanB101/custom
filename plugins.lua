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
        opts = require("custom.opts.mason"),
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
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.after.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.after.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
    {
        "mfussenegger/nvim-dap",
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end
    },
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
    -- quarto
    { -- completion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-emoji',
            'saadparwaiz1/cmp_luasnip',
            'f3fora/cmp-spell',
            'ray-x/cmp-treesitter',
            'kdheepak/cmp-latex-symbols',
            'jmbuhr/cmp-pandoc-references',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
            'onsails/lspkind-nvim',
            'jmbuhr/otter.nvim',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            local lspkind = require 'lspkind'

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },
                mapping = {
                    ['<C-n>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-p>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<c-y>'] = cmp.mapping.confirm {
                        select = true,
                    },
                    ['<CR>'] = cmp.mapping.confirm {
                        select = true,
                    },

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                },
                autocomplete = false,

                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    format = lspkind.cmp_format {
                        mode = 'symbol',
                        menu = {
                            otter = '[🦦]',
                            nvim_lsp = '[LSP]',
                            luasnip = '[snip]',
                            buffer = '[buf]',
                            path = '[path]',
                            spell = '[spell]',
                            pandoc_references = '[ref]',
                            tags = '[tag]',
                            treesitter = '[TS]',
                            calc = '[calc]',
                            latex_symbols = '[tex]',
                            emoji = '[emoji]',
                        },
                    },
                },
                sources = {
                    { name = 'otter' }, -- for code chunks in quarto
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'luasnip',                keyword_length = 3, max_item_count = 3 },
                    { name = 'pandoc_references' },
                    { name = 'buffer',                 keyword_length = 5, max_item_count = 3 },
                    { name = 'spell' },
                    { name = 'treesitter',             keyword_length = 5, max_item_count = 3 },
                    { name = 'calc' },
                    { name = 'latex_symbols' },
                    { name = 'emoji' },
                },
                view = {
                    entries = 'native',
                },
            }

            -- link quarto and rmarkdown to markdown snippets
            luasnip.filetype_extend('quarto', { 'markdown' })
            luasnip.filetype_extend('rmarkdown', { 'markdown' })
        end,
    },
    {
        'quarto-dev/quarto-nvim',
        ft = { 'quarto' },
        dev = false,
        opts = {
            lspFeatures = {
                languages = { 'r', 'python', 'julia', 'bash', 'lua', 'html', 'dot', 'javascript', 'typescript', 'ojs' },
            },
            codeRunner = {
                enabled = true,
                default_method = 'slime',
            },
        },
        dependencies = {
            -- added as a nvim-cmp source in lua/plugins/completion.lua
            'jmbuhr/otter.nvim',
        },
    },
    { -- send code from python/r/qmd documets to a terminal or REPL
        -- like ipython, R, bash
        'jpalardy/vim-slime',
        init = function()
            vim.b['quarto_is_python_chunk'] = false
            Quarto_is_in_python_chunk = function()
                require('otter.tools.functions').is_otter_language_context 'python'
            end

            vim.cmd [[
              let g:slime_dispatch_ipython_pause = 100

              function SlimeOverride_EscapeText_quarto(text)
                  call v:lua.Quarto_is_in_python_chunk()
                      if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
                          return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
                      else if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
                          return [a:text, "\n"]
                      else
                          return [a:text]
                      end
                  end
              endfunction
            ]]

            vim.g.slime_target = 'neovim'
            vim.g.slime_python_ipython = 1
        end,
        config = function()
            local function mark_terminal()
                vim.g.slime_last_channel = vim.b.terminal_job_id
            end

            local function set_terminal()
                vim.b.slime_config = { jobid = vim.g.slime_last_channel }
            end
            vim.keymap.set('n', '<leader>cm', mark_terminal, { desc = '[m]ark terminal' })
            vim.keymap.set('n', '<leader>cs', set_terminal, { desc = '[s]et terminal' })
        end,
    },
    {
        'HakonHarnes/img-clip.nvim',
        event = 'BufEnter',
        ft = { 'markdown', 'quarto', 'latex' },
        opts = {
            filetypes = {
                markdown = {
                    url_encode_path = true,
                    template = '![$CURSOR]($FILE_PATH)',
                    drag_and_drop = {
                        download_images = false,
                    },
                },
                quarto = {
                    url_encode_path = true,
                    template = '![$CURSOR]($FILE_PATH)',
                    drag_and_drop = {
                        download_images = false,
                    },
                },
            },
        },
        config = function(_, opts)
            require('img-clip').setup(opts)
            vim.keymap.set('n', '<leader>ii', ':PasteImage<cr>', { desc = 'insert [i]mage from clipboard' })
        end,
    },
    {
        'jbyuki/nabla.nvim',
        keys = {
            { '<leader>qm', ':lua require"nabla".toggle_virt()<cr>', desc = 'toggle [m]ath equations' },
        },
    },
    {
        'benlubas/molten-nvim',
        enabled = false,
        build = ':UpdateRemotePlugins',
        init = function()
            vim.g.molten_image_provider = 'image.nvim'
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
        end,
        keys = {
            { '<leader>mi', ':MoltenInit<cr>',           desc = '[m]olten [i]nit' },
            {
                '<leader>mv',
                ':<C-u>MoltenEvaluateVisual<cr>',
                mode = 'v',
                desc = 'molten eval visual',
            },
            { '<leader>mr', ':MoltenReevaluateCell<cr>', desc = 'molten re-eval cell' },
        },
    },
    {
        'jmbuhr/otter.nvim',
        dev = false,
        dependencies = {
            {
                'neovim/nvim-lspconfig',
                'nvim-treesitter/nvim-treesitter',
                'hrsh7th/nvim-cmp',
            },
        },
        opts = {
            buffers = {
                set_filetype = true,
                write_to_disk = false,
            },
            handle_leading_whitespace = true,
        },
    }
}

return plugins
