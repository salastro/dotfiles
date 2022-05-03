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
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-a>'] = cmp.mapping.abort(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
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
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
------Enable (broadcasting) snippet capability for completion
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Toggle diagnostics.
function _G.toggle_diagnostics()
    if vim.g.diagnostics_visible then
        vim.g.diagnostics_visible = false
        vim.diagnostic.disable()
    else
        vim.g.diagnostics_visible = true
        vim.diagnostic.enable()
    end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local opts = { noremap=true, silent=true }
local servers = { 'pylsp', 'clangd', 'texlab', 'bashls', 'html', 'cssls', 'eslint', }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = function(client, bufnr)
            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-h>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ldf',  '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ldd',  '<cmd>call v:lua.toggle_diagnostics()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf',  '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
            if vim.bo.filetype == "tex" then
                -- Do not remap K if it is a latex file because of VimTex plugin
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            else
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            end
            -- vim.cmd('au BufEnter *.tex nnoremap <buffer> K <Plug>(vimtex-doc-package)')
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lre', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',          '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',          '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',          '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        end,
        capabilities = capabilities,
    }
end

-- Setup treesitter.
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "javascript", "cpp", "python", "latex", "bibtex", "html", "css", "c", "rust", "bash", "lua", "make", },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        -- disable = { "vim", },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gt",
            node_incremental = "gn",
            scope_incremental = "gS",
            node_decremental = "gp",
        },
    },
    indent = {
        enable = true
    },
    playground = {
        enable = true,
    }
}

-- use bash treesitter for zsh
local ft_to_lang = require('nvim-treesitter.parsers').ft_to_lang
require'nvim-treesitter.parsers'.ft_to_lang = function(ft)
    if ft == 'zsh' then
        return 'bash'
    end
    return ft_to_lang(ft)
end

-- other
require("which-key").setup()
require("scrollbar").setup()
