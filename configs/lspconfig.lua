local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local servers = {
    "clangd",
    "jdtls",
    "html",
    -- npm install -g typescript-language-server typescript
    "sqlls",
    "lemminx",
    -- run nvim command `LspInstall slint`
    -- run nvim command `TSInstall slint` for syntax highligh
    "slint_lsp",
    "texlab",
    "kotlin_language_server",
    "zls",
}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

lspconfig.tsserver.setup({
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
    end,
    capabilities = capabilities,
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
