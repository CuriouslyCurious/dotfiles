-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- NOTE: 'do' and 'for' need to be wrapped in brackets: ['do'] ['for']
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
    Plug 'editorconfig/editorconfig-vim'    -- For standardising code-style via .editorconfig files
    Plug 'terryma/vim-expand-region'        -- Select increasingly large regions of text

    -- tpope magic
    Plug 'tpope/vim-surround'               -- Make replacing quotes and such easier (cs)
    Plug 'tpope/vim-repeat'                 -- Repeat more actions
    --Plug 'tpope/vim-fugitive'
    --Plug 'tpope/vim-sensible'

    Plug 'andymass/vim-matchup'             -- Navigate between sets of matching texts (%)
    --Plug 'terryma/vim-smooth-scroll'        -- Because it is fancy
    --noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    --noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    --noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    --noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

    -- Auto insert matching delimiters
    -- Plug 'Raimondi/delimitMate'
    -- Disable auto-closing for tags to ensure closetag can do its thing
    --let delimitMate_matchpairs = "(:),[:],{:}"
    --autocmd! FileType html,xhtml,phtml,liquid let b:delimitMate_matchpairs = "(:),[:],{:}"

    -- webdev (yuck)
    --Plug 'alvan/vim-closetag'
    --let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.liquid'
    --let g:closetag_filetypes = '*.html,*.xhtml,*.phtml,*.liquid'

    -- ctag bar
    -- XXX: Might delete this and just use the quickfix bar instead
    Plug 'majutsushi/tagbar'

    -- Undo trees
    Plug 'sjl/gundo.vim'
    vim.g['gundo_prefer_python3'] = 1

    -- Latex
    Plug 'lervag/vimtex'
    vim.g['tex_flavor'] = 'latex'
    --let g:vimtex_fold_enabled = 1
    vim.g['vimtex_view_method'] = 'zathura'
    vim.g['vimtex_compiler_progname'] = 'nvr'
    vim.g['vimtex_compiler_latexmk'] = {
        ['options'] = {
            '-shell-escape',
            '-xelatex',
            '-verbose',
            '-file-line-error',
            '-interaction=nonstopmode',
        }
    }

    -- Markdown
    Plug('iamcco/markdown-preview.nvim', { ['do'] =  vim.fn['mkdp#util#install()'], ['for'] = {'markdown', 'vim-plug'} })
    vim.g['mkdp_auto_start'] = 1
    vim.g['mkdp_auto_close'] = 1
    Plug 'mzlogin/vim-markdown-toc'

    -- Mail
    Plug('soywod/himalaya', {rtp = 'vim'})
        vim.g['himalaya_mailbox_picker'] = 'telescope'

    -- Syntax highlighting (treesitter)
    Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
    -- Plug 'nvim-treesitter/playground'

    -- Colorize hex codes
    Plug 'norcalli/nvim-colorizer.lua'

    -- Theme
    Plug('https://gitlab.com/CuriouslyCurious/material-monokai.nvim', {branch = 'dev'})
        vim.g['colorscheme'] = 'material-monokai'

    -- Highlight Todo comments
    Plug 'folke/todo-comments.nvim'

    -- Show available keybinds while typing a keybind
    Plug 'folke/which-key.nvim'

    -- Airline but Lua (TODO: Add tabbar support or switch to another statusline)
    -- TODO: Also add material-monokai theme
    Plug 'hoob3rt/lualine.nvim'
    Plug 'ryanoasis/vim-devicons' -- more icons

    -- Barline
    Plug 'romgrk/barbar.nvim'

    -- Pretty debugging
    Plug 'folke/trouble.nvim'
        vim.keymap.set('n', '<silent> <C-t>', '<cmd>TroubleToggle<cr>')
        vim.keymap.set('n', '<silent> <leader>tq', '<cmd>TroubleToggle quickfix<cr>')
        vim.keymap.set('n', '<silent> <leader>tl', '<cmd>TroubleToggle loclist<cr>')
        vim.keymap.set('n', '<silent> <leader>xw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
        vim.keymap.set('n', '<silent> <leader>xd', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
        --nnoremap gR <cmd>TroubleToggle lsp_references<cr>
    Plug 'mfussenegger/nvim-dap'
        vim.keymap.set('n', '<silent> <leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
        vim.keymap.set('n', '<silent> <leader>dc', "<cmd>lua require'dap'.continue()<cr>")
        vim.keymap.set('n', '<silent> <leader>dso', "<cmd>lua require'dap'.step_over()<cr>")
        vim.keymap.set('n', '<silent> <leader>dsi', "<cmd>lua require'dap'.step_into()<cr>")

    -- LSP
    Plug 'neovim/nvim-lspconfig'
    -- Autocompletion
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    -- Snippets
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    -- LSP status for statuslines
    Plug 'nvim-lua/lsp-status.nvim'

    -- Rust
    Plug 'simrat39/rust-tools.nvim'
    Plug('saecki/crates.nvim', {tag = 'v0.2.1'})

    -- Autopairing
    Plug 'windwp/nvim-autopairs'

    -- EasyMotion (Vimium-style navigation)
    Plug('phaazon/hop.nvim', {tag =  '*'})

    -- Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
        -- Find files using Telescope command-line sugar.
        vim.keymap.set('n', '<C-o>', '<cmd>Telescope find_files<cr>')
        vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
        vim.keymap.set('n', '<leader>ft', '<cmd>Telescope git_files<cr>')
        vim.keymap.set('n', '<leader>fc', '<cmd>Telescope git_commits<cr>')
        vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
        vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
        vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

    -- Fancy highlighting
    Plug('lukas-reineke/indent-blankline.nvim', {tag = '*'})

    -- Comment
    Plug 'numToStr/Comment.nvim'

    -- Git gutter
    -- Requires plenar
    Plug('lewis6991/gitsigns.nvim', {tag = '*'})

    -- Markdown preview
    -- Plug 'npxbr/glow.nvim', {'do': ':GlowInstall', 'branch': 'main'}

    -- file explorer
    Plug 'kyazdani42/nvim-web-devicons' -- for file icons
    Plug 'kyazdani42/nvim-tree.lua'
        vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
vim.call('plug#end')
