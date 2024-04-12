local M = {}

M.general = {
    n = {
        ["<leader>s"] = { ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", "replace ocurrencies" },
        -- Center cursor with some commands
        ["J"] = { "mzJ`z", "J maintains cursor position" },
        ["<C-d>"] = { "<C-d>zz", "centeres <C-d>" },
        ["<C-u>"] = { "<C-u>zz", "centeres <C-u>" },
        ["n"] = { "nzzzv", "Centered cursor n" },
        ["N"] = { "Nzzzv", "Centered cursor N" },
        -- Yanking and pasting from a to clipboard
        ["<leader>y"] = { "\"+y", "yank to clipboard" },
        ["<leader>p"] = { "\"+p", "paste from clipboard" },
        -- Delete to void
        ["D"] = { "\"_d", "delete" },
        -- Evading muscle memory problems
        ["Q"] = { "<nop>", "" },
        ["<C-z>"] = { "<nop>", "" },
        -- Redo
        ["U"] = { "<C-r>", "redo" },
    },
    v = {
        -- Yanking and pasting from a to clipboard
        ["<leader>p"] = { "\"+p", "paste from clipboard" },
        ["<leader>y"] = { "\"+y", "yank to clipboard" },
        -- Delete to void
        ["D"] = { "\"_d", "delete" },
    },
    x = {
        -- Replacing lines
        ["c"] = { "\"_dP", "replace with register" },
        ["C"] = { "\"_d\"+P", "replace with clipboard" },
    },
}
M.luasnip = {
    n = {
        ['<Leader>L'] = {
            function()
                require("luasnip.loaders.from_lua")
                    .load({ paths = "~/.config/nvim/lua/custom/snippets/" })
            end,
            "reload snippets"
        }
    }
}
M.trouble = {
    n = {
        ["q"] = { "<cmd> TroubleToggle<CR>", "toggle trouble" },
    },
}
M.undoTree = {
    n = {
        ["<leader>u"] = { "<cmd> UndotreeToggle<CR>", "toggle undo tree" },
    },
}
M.tmuxNavigation = {
    n = {
        ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
        ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
        ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
        ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up" },
    },
}
M.debugging = {
    n = {
        ["<leader>b"] = { "<cmd> DapToggleBreakpoint<CR>", "toggle break point" },
        ["<leader>db"] = {
            function()
                local widgets = require("dap.ui.widgets")
                local sidebar = widgets.sidebar(widgets.scopes)
                sidebar.open()
            end,
            "open debugging sidebar"
        }
    },
}
M.spectre = {
    n = {
        ['<leader>S'] = {
            '<cmd>lua require("spectre").toggle()<CR>',
            'Toggle Spectre',
        },
        ['<leader>sw'] = {
            '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
            'Search current word'
        },
        ['<leader>sp'] = {
            '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
            'Search on current file'
        },
    },
    v = {
        ['<leader>sw'] = {
            '<esc><cmd>lua require("spectre").open_visual()<CR>',
            'Search current word'
        }
    }
}

return M
