local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
local servers = {
    "clangd",
    "cssls",
    "html",
    "kotlin_language_server",
    "lua_ls",
    "lemminx",
    "intelephense",
    "sqls",
    "texlab",
    "zls",
}


for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_init = function(client)
        --     if client.server_capabilities then
        --         client.server_capabilities.documentFormattingProvider = false
        --         client.server_capabilities.semanticTokensProvider = false -- turn off semantic tokens
        --     end
        -- end,
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "bash", "zsh" },
})

-- npm install -g typescript-language-server typescript
lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local utils = require "core.utils"

        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        utils.load_mappings("lspconfig", { buffer = bufnr })

        if client.server_capabilities.signatureHelpProvider then
            require("nvchad.signature").setup(client)
        end

        if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})

lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "rust" },
    root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust-analyser'] = {
            allFeatures = true,
        }
    }

})

lspconfig.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", "git"),
    settings = {
        gopls = {
            completeUnimported = true,
            analyses = {
                unusedparams = true,
            }
        }
    }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.marksman.setup {
    capabilities = capabilities,
    filetypes = { 'markdown', 'quarto' },
    root_dir = util.root_pattern('.git', '.marksman.toml', '_quarto.yml'),
}

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "python" },
})
