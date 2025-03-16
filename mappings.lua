local M = {}

M.general = {
    n = {
        ["<leader>s"] = { ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", "replace ocurrencies" },

        ["J"] = { "mzJ`z", "J maintains cursor position" },
        ["<C-d>"] = { "<C-d>zz", "centeres <C-d>" },
        ["<C-u>"] = { "<C-u>zz", "centeres <C-u>" },
        ["n"] = { "nzzzv", "Centered cursor n" },
        ["N"] = { "Nzzzv", "Centered cursor N" },
        ["<leader>y"] = { "\"+y", "yank to clipboard" },
        ["<leader>p"] = { "\"+p", "paste from clipboard" },
        ["D"] = { "\"_d", "delete" },
        ["<C-z>"] = { "<nop>", "avoiding problems" },
        ["U"] = { "<C-r>", "redo" },

        ["m"] = { function() vim.diagnostic.goto_next() end, "next diagnostic" },
        ["M"] = { function() vim.diagnostic.goto_prev() end, "prev diagnostic" },

        ["<leader>tf"] = { function()
            local qf_exists = false
            for _, win in pairs(vim.fn.getwininfo()) do
                if win["quickfix"] == 1 then
                    qf_exists = true
                end
            end
            if qf_exists == true then
                vim.cmd "cclose"
                return
            end
            if not vim.tbl_isempty(vim.fn.getqflist()) then
                vim.cmd "copen"
            end
        end
        , "toggle quickfix list" },
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
        ['<leader>s'] = { function() require("spectre").toggle() end, "toggle Spectre" },
        ['<leader>sw'] = { function() require("spectre").open_visual({ select_word = true }) end, "toggle spectre" },
        ['<leader>sp'] = { function() require("spectre").open_file_search({ select_word = true }) end, "toggle spectre" },
    },
    v = {
        ['<leader>sw'] = { function() require("spectre").open_visual() end, "toggle Spectre" },
    }
}
M.latex = {
    n = {
        ["<leader>v"] = { "<cmd> VimtexView<CR>", "vimtex view" },
    }
}

return M
