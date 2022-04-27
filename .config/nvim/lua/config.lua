-- impatient to load faster
require('impatient')

-- lsp
require'lspconfig'.cssls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.texlab.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.eslint.setup{}

-- cmp
local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        { name = 'spell' },
        { name = 'nvim_lsp' },
        { name = 'omni' },
        { name = 'ultisnips' },
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- cmp.setup.cmdline(':', {
--     sources = cmp.config.sources({
--         { name = 'path' }
--     }, {
--         { name = 'cmdline' }
--     })
-- })

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig')['pylsp'].setup { capabilities = capabilities }
require('lspconfig')['clangd'].setup { capabilities = capabilities }
require('lspconfig')['texlab'].setup { capabilities = capabilities }
require('lspconfig')['bashls'].setup { capabilities = capabilities }
require('lspconfig')['html'].setup { capabilities = capabilities }
require('lspconfig')['cssls'].setup { capabilities = capabilities }
require('lspconfig')['eslint'].setup { capabilities = capabilities }

-- other
require("which-key").setup()
require("scrollbar").setup()
