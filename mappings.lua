local M = {}

M.general = {
  n = {
    -- Better window navigation
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left"},
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right"},
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down"},
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR>", "window up"},
    -- For convienience
    -- ["<leader>s"] = {"[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]", ""},
    -- Center cursor with some commands
    ["J"] = {"mzJ`z", ""},
    ["<C-d>"] = {"<C-d>zz", ""},
    ["<C-u>"] = {"<C-u>zz", ""},
    ["n"] = {"nzzzv", "Centered cursor n"},
    ["N"] = {"Nzzzv", "Centered cursor N"},
    -- Yanking and pasting from a to clipboard
    ["<leader>y"] = {"\"+y", ""},
    ["<leader>pc"] = {"\"+p", ""},
    -- Delete to void
    ["<leader>d"] = {"\"_d", ""},
    -- Evading muscle memory problems
    ["Q"] = {"<nop>", ""},
    ["<C-z>"] = {"<nop>", ""},
  },
  v = {
    ["<leader>pc"] = {"\"+p", ""},
    ["<leader>y"] = {"\"+y", ""},
    ["<leader>d"] = {"\"_d", ""},
  },
  x = {
    ["<leader>p"] = {"\"_dP", ""},
  },
}

return M
