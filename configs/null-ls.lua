local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
    ensure_installed = {
        "prettier",
    },
    sources = {
        -- go
        -- go install mvdan.cc/gofupmt v0.5.0
        -- formatting.gofupmt,
        -- go install github.com/incu6us/goimports-reviser/v3@latest
        -- formatting.goimports_reviser,
        -- go install github.com/segmentio/golines v0.11.0
        -- formatting.golines,
        -- formatting.clang_format,
        formatting.prettier,
        -- python
        diagnostics.ruff,
        diagnostics.mypy,
        formatting.black,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
                group = augroup,
                buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
