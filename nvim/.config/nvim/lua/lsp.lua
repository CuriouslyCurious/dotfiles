-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspflags = {
    -- Default since Nvim 0.7+
    debounce_text_changes = 150,
}

-- lspconfig
local nvim_lsp = require('lspconfig')

vim.diagnostic.config {
    virtual_text = true,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lsp status
--local lsp_status = require('lsp-status')

--lsp_status.config {
    --kind_labels = {},
   -- • `current_function`: Boolean, `true` if the current function
   --   should be updated and displayed in the default statusline
   --   component. Shows the current function, method, class,
   --   struct, interface, enum, module, or namespace.
   --current_function = true,
   -- • `show_filename`: Boolean, `true` if the filename should be
   --   displayed in the progress text.
   --show_filename = true
   -- • `indicator_errors` : Symbol to place next to the error count
   --   in `status` . Default: '',
   -- • `indicator_warnings` : Symbol to place next to the warning
   --   count in `status` . Default: '',
   -- • `indicator_info` : Symbol to place next to the info count in
   --   `status` . Default: '🛈',
   -- • `indicator_hint` : Symbol to place next to the hint count in
   --   `status` . Default: '❗',
   -- • `indicator_ok` : Symbol to show in `status` if there are no
   --   diagnostics. Default: '',
   -- • `spinner_frames` : Animation frames for progress spinner in
   --   `status` . Default: { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'
   --   },
   -- • `status_symbol` : Symbol to start the statusline segment in
   --   `status` . Default: ' 🇻',
   -- • `diagnostics` : Boolean, `true` by default. If `false`, the
   --   default statusline component does not include LSP diagnostic
   --   counts.
--}

--lsp_status.register_progress()


-- Global mappings
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.set_loclist, opts)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user_lsp_config", {}),
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        --Enable completion triggered by <c-x><c-o>
        vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = bufnr }
        -- , noremap=true, silent=true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        -- vim.keymap.set('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

        -- Function to check if a floating dialog exists and if not
        -- then check for diagnostics under the cursor
        -- https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830
        function OpenDiagnosticIfNoFloat()
            for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
                if vim.api.nvim_win_get_config(winid).zindex then
                    return
                end
            end
            -- THIS IS FOR BUILTIN LSP
            vim.diagnostic.open_float(0, {
                focusable = false,
                border = 'rounded',
                scope = "cursor",
                close_events = {
                    "BufLeave",
                    "BufHidden",
                    "CursorMoved",
                    "CursorMovedI",
                    "FocusLost",
                    "InsertEnter",
                    "InsertCharPre",
                    "WinLeave",
                },
            })
        end
        -- Show diagnostics under the cursor when holding position
        -- FIXME
        vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            group = "lsp_diagnostics_hold",
            callback = OpenDiagnosticIfNoFloat,
        })
        if client.server_capabilities.document_highlight then
            vim.api.nvim_create_augroup('lsp_document_highlight', {})
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = 'lsp_document_highlight',
                buffer = 0,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd('CursorMoved', {
                group = 'lsp_document_highlight',
                buffer = 0,
                callback = vim.lsp.buf.clear_references,
            })
        -- Enable inlay hints
        -- https://vinnymeller.com/posts/neovim_nightly_inlay_hints/
        -- TODO: Requires >0.10
        elseif client.server_capabilities.inlayHintProvider then
            -- vim.lsp.inlay_hint(bufnr, true)
        end
    end,
})

nvim_lsp['clangd'].setup{
    cmd = {'clangd'},
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

nvim_lsp['pyright'].setup{
    cmd = {'pyright'},
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

nvim_lsp['texlab'].setup{
    cmd = {'texlab'},
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
}

nvim_lsp['rust_analyzer'].setup{
    cmd = {'rust-analyzer'},
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    settings = {
        assist = {
            importGranularity = "module",
            importPrefix = "self",
        },
        cargo = {
            loadOutDirsFromCheck = true,
        },
        procMacro = {
            enable = true,
        },
        checkOnSave = {
            command = "clippy",
        }
    }
}

-- Completion
vim.o.completeopt = 'menu,menuone,noinsert'

-- (helper functions for nvim-cmp tab completion)
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'crates' },
    },
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
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

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

