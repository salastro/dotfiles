-- impatient to load faster
require('impatient')

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
        { name = 'calc' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
        { name = 'spell' },
        { name = 'path' },
    }),
    sorting = ({
        comparators = {
            function(...) return require('cmp_buffer'):compare_locality(...) end,
            -- The rest of your comparators...
        }
    }),
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
            { name = 'cmdline', }
        }),
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

-- Mappings.
local opts = { noremap=true, silent=true, buffer=true }
local on_attach = function(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<M-h>',       '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>df', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>call v:lua.toggle_diagnostics()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf',  '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    if vim.bo.filetype == "tex" then
        -- Do not remap K if it is a latex file because of VimTex plugin
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>h',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    else
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',       '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',          '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',          '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',          '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI',          '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer=true })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer=true })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
local servers = { 'pylsp', 'clangd', 'texlab', 'bashls', 'html', 'cssls', 'eslint', 'sqlls' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

require'lspconfig'.pylsp.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pylsp = {
            configurationSources = {"pylint"},
            plugins = {
                pylint = { enabled = true },
                flake8 = { enabled = false },
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
            }
        }
    },
}

-- Setup treesitter.
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "javascript", "cpp", "python", "latex", "bibtex", "html", "css", "c", "rust", "bash", "lua", "make", "vim" },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "latex" },
        -- disable = function(bufnr)
        --     return vim.api.nvim_buf_line_count(bufnr) > 5000
        -- end,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gn",
            node_incremental = "gn",
            node_decremental = "gp",
        },
    },
    indent = {
        enable = true,
        disable = { "python", },
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
    },
    matchup = {
        enable = false,              -- mandatory, false will disable the whole extension
        -- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
        -- [options]
        -- disable_virtual_text = true,
        -- include_match_words = true,
    },
}

-- Setup status line.
require('lualine').setup {
    options = {
        icons_enabled = true,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
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
    extensions = {'fzf', 'man', 'quickfix', 'nvim-tree'},
}

-- Setup indent lines.
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

require("nvim-tree").setup()

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})

require('gitsigns').setup {
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '―' },
        topdelete    = { text = '―' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = true,  -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
}

require'tabline'.setup {
    -- Defaults configuration options
    enable = true,
    options = {
        -- If lualine is installed tabline will use separators configured in lualine by default.
        -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        -- max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = false, -- shows base filename only instead of relative path in filename
        modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
    }
}

-- other
require('which-key').setup()
require('hop').setup()
require('hlslens').setup()
