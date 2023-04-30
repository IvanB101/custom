local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

null_ls.setup {
  debug = true,
  sources = {
    formatting.stylua,
    formatting.clang_format,

    lint.shellcheck,
  },
}
