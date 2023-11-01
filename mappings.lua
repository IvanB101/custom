local M = {}

M.general = {
  n = {
    ["xx"] = { "<cmd> TroubleToggle<CR>", "toggle trouble"},

    ["<leader>u"] = { "<cmd> UndotreeToggle<CR>", "toggle undo tree"},

    ["<leader>gb"] = { "<cmd> Telescope git_branches <CR>", "Git branches" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    -- Better window navigation
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left"},
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right"},
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down"},
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up"},

    ["<leader>s"] = {":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", "replace ocurrencies"},
    -- Center cursor with some commands
    ["J"] = {"mzJ`z", "J maintains cursor position"},
    ["<C-d>"] = {"<C-d>zz", "centeres <C-d>"},
    ["<C-u>"] = {"<C-u>zz", "centeres <C-u>"},
    ["n"] = {"nzzzv", "Centered cursor n"},
    ["N"] = {"Nzzzv", "Centered cursor N"},
    -- Yanking and pasting from a to clipboard
    ["<leader>y"] = {"\"+y", "yank to clipboard"},
    ["<leader>pc"] = {"\"+p", "paste from clipboard"},
    -- Delete to void
    ["<leader>d"] = {"\"_d", "delete"},
    -- Evading muscle memory problems
    ["Q"] = {"<nop>", ""},
    ["<C-z>"] = {"<nop>", ""},
  },
  v = {
    ["<leader>pc"] = {"\"+p", "paste from clipboard"},
    ["<leader>y"] = {"\"+y", "yank to clipboard"},
    ["<leader>d"] = {"\"_d", "delete"},
  },
  x = {
    ["<leader>p"] = {"\"_dP", "replace highlighted"},
  },
}
M.touble = {

}

return M
