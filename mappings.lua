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
        ["<leader>d"] = { "\"_d", "delete" },
        -- Evading muscle memory problems
        ["Q"] = { "<nop>", "" },
        ["<C-z>"] = { "<nop>", "" },
    },
    v = {
        ["<leader>p"] = { "\"+p", "paste from clipboard" },
        ["<leader>y"] = { "\"+y", "yank to clipboard" },
        ["<leader>d"] = { "\"_d", "delete" },
    },
    x = {
        ["rp"] = { "\"_dP", "replace highlighted with clipboard" },
        ["<leader>rp"] = { "\"_dP", "replace highlighted with register" },
    },
}
M.touble = {
    n = {
        ["xx"] = { "<cmd> TroubleToggle<CR>", "toggle trouble" },
    },
}
M.undoTree = {
    n = {
        ["<leader>u"] = { "<cmd> UndotreeToggle<CR>", "toggle undo tree" },
    },
}
M.gitTelescope = {
    n = {
        ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
        ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
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
M.touble = {
    n = {
        ["<leader>db"] = { "<cmd> DapToggleBreakpoint<CR>", "toggle break point" },
        ["<leader>dg"] = {
            function()
                local widgets = require("dap.ui.widgets")
                local sidebar = widgets.sidebar(widgets.scopes)
                sidebar.open()
            end,
            "open debugging sidebar"
        }
    },
}

return M
