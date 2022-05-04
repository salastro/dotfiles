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
vim.g.diagnostics_visible = true
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
    ensure_installed = { "javascript", "cpp", "python", "latex", "bibtex", "html", "css", "c", "rust", "bash", "lua", "make", },
    sync_install = false,
    highlight = {
        enable = true,
        -- disable = { "vim", },
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
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["acl"] = "@class.outer",
                ["icl"] = "@class.inner",
                ["acm"] = "@comment.outer",
                ["icm"] = "@comment.outer",
            },
        },
        swap = {
            enable = true,
            -- swap_next = {
            --     ["<leader>"] = "@parameter.inner",
            -- },
            -- swap_previous = {
            --     ["<leader>"] = "@parameter.inner",
            -- },
        },
    },
    matchup = {
        enable = false,              -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        -- [options]
        -- disable_virtual_text = true,
        -- include_match_words = true,
    },
}

-- use bash treesitter for zsh
local ft_to_lang = require('nvim-treesitter.parsers').ft_to_lang
require'nvim-treesitter.parsers'.ft_to_lang = function(ft)
    if ft == 'zsh' then
        return 'bash'
    end
    return ft_to_lang(ft)
end

-- Setup status line.
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

require("scrollbar").setup({
    show = true,
    set_highlights = true,
    folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = false, -- disables if no. of lines in buffer exceeds this
    handle = {
        text = " ",
        color = nil,
        cterm = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
        Search = {
            text = { "—", "=" },
            priority = 0,
            color = "#d65d0e",
            cterm = nil,
            highlight = "Search",
        },
        Error = {
            text = { "—", "=" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
            text = { "—", "=" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
            text = { "—", "=" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
            text = { "—", "=" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
            text = { "—", "=" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "Normal",
        },
    },
    excluded_buftypes = {
        "terminal",
    },
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
    },
    handlers = {
        diagnostic = true,
        search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
    },
})

-- other
require('which-key').setup()
require('hop').setup()
