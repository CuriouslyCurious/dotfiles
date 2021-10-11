" NVIM General Settings (differs from .vimrc)
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
set signcolumn=yes

call plug#begin('~/.config/nvim/plugged')

" Syntax highlighting (treesitter)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
    " Make folding be based on treesitter
    " Sexy Folds by u/Rafat913
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
    set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))
    set fillchars=fold:\\
    set foldnestmax=3
    set foldminlines=1
    set foldlevel=99
    set indentexpr=nvim_treesitter#indent()
    " TODO: Statusline indicator
    " echo nvim_treesitter#statusline(90)
    " module->expression_statement->call->identifier

" Colorize hex codes
Plug 'norcalli/nvim-colorizer.lua'

" Theme
Plug 'curiouslycurious/monokai.nvim'

" Highlight Todo comments
Plug 'folke/todo-comments.nvim'

" Airline but Lua (TODO: Add tabbar support or switch to another statusline)
" TODO: Also add material-monokai theme
Plug 'hoob3rt/lualine.nvim'
Plug 'ryanoasis/vim-devicons' " more icons

" Barline
Plug 'romgrk/barbar.nvim'

" Pretty debugging
Plug 'folke/trouble.nvim'
    nnoremap <leader>xx <cmd>TroubleToggle<cr>
    nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
    nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
    nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
    nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
    "nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
" Snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'L3MON4D3/LuaSnip'

" Autopairing
Plug 'windwp/nvim-autopairs'

" EasyMotion (Vimium-style navigation)
Plug 'phaazon/hop.nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
    " Find files using Telescope command-line sugar.
    nnoremap <C-o> <cmd>Telescope find_files<cr>
    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>ft <cmd>Telescope git_files<cr>
    nnoremap <leader>fc <cmd>Telescope git_commits<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Fancy highlighting
" Plug 'lukas-reineke/indent-blankline.nvim'


" Git gutter
" Requires plenar
Plug 'lewis6991/gitsigns.nvim'

" Markdown preview
" Plug 'npxbr/glow.nvim', {'do': ':GlowInstall', 'branch': 'main'}

" file explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
    nnoremap <C-n> :NvimTreeToggle<CR>

" Highlight yanked region
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

" Source the OG dotfile
source ~/.vimrc

lua << EOF

-- LSP
local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    lsp_status.on_attach(client)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    buf_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "pyright", "rust_analyzer", "texlab" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Completion
vim.o.completeopt = 'menu,menuone,noinsert'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
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
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- nvim-autopairs
local npairs = require('nvim-autopairs')
npairs.setup {
    check_ts = true,
}

require("nvim-autopairs.completion.cmp").setup {
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = true, -- automatically select the first item
}

-- Treesitter setup
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    --[ custom_captures = {
    -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
    --  ["foo.bar"] = "Identifier",
    --},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  -- Experimental indentation based on treesitter
  indent = {
    enable = true
  },
  autopairs = {
    enable = true
  },
}

-- blankline indent
--vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f blend=nocombine]]
--vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1a1a1a blend=nocombine]]
--require("indent_blankline").setup {
--    char_highlight_list = {
--        "IndentBlanklineIndent1",
--        "IndentBlanklineIndent2",
--    },
--    show_trailing_blankline_indent = false,
--}

-- Hop
require'hop'.setup()
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Colorizer
require'colorizer'.setup()

-- Gitsigns
require('gitsigns').setup()
--{
--  signs = {
--    add = { hl = 'GitGutterAdd', text = '+' },
--    change = { hl = 'GitGutterChange', text = '~' },
--    delete = { hl = 'GitGutterDelete', text = '_' },
--    topdelete = { hl = 'GitGutterDelete', text = '‾' },
--    changedelete = { hl = 'GitGutterChange', text = '~' },
--  },
--}

-- Lualine
require('lualine').setup{
    options = {
        theme = 'ayu_mirage',
    },
}

-- Todo comments
require("todo-comments").setup()
EOF
