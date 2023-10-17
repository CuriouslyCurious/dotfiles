-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- NOTE: 'do' and 'for' need to be wrapped in brackets: ['do'] ['for']
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
    -- Asynchronous
    Plug 'nvim-lua/plenary.nvim'

    -- Syntax highlighting (treesitter)
    Plug('nvim-tree/nvim-web-devicons')
    Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

    -- Collection of a bunch of cool stuff
     Plug 'echasnovski/mini.nvim'

    -- Undo trees
    Plug 'mbbill/undotree'
    -- Plug 'nvim-treesitter/playground'
    -- Colorize hex codes
    --Plug 'norcalli/nvim-colorizer.lua'
    -- Highlight Todo comments
    -- Theme
    Plug('https://git.sr.ht/~curious/material-monokai.nvim', {branch = 'dev'})
    -- Plug('catppuccin/nvim', {['as'] = 'c]atppuccin'})
    -- Icons
    Plug 'ryanoasis/vim-devicons'

    -- Git gutter
    Plug('lewis6991/gitsigns.nvim', {tag = '*'})

    -- file explorer
    -- Plug 'kyazdani42/nvim-web-devicons' -- for file icons
    -- Plug 'kyazdani42/nvim-tree.lua'
    --     vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')

    -- skim/fzf
    Plug('nvim-telescope/telescope.nvim', {tag = '0.1.1'})

    --Plug('junegunn/fzf', { ['do'] = { fzf#install() } })
    -- Plug 'junegunn/fzf.vim'
    --     vim.g.fzf_preview_window = {{'right:50%', 'alt-h'}}
    --     vim.api.nvim_create_user_command('Files',
    --         "call fzf#vim#files(<q-args>, <bang>0)",
    --         { nargs = '*', complete = 'dir' }
    --     )
    --     vim.keymap.set('n', '<C-o>', '<cmd>Files<cr>')
    -- Plug('lotabout/skim', { dir = '~/.skim', ['do'] = './install' })
    -- Plug('lotabout/skim.vim')
    --     -- Requires neovim > 0.7
    --     vim.api.nvim_create_user_command('Ag',
    --         "call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('right:50%', 'alt-h'))",
    --         { nargs = '*' }
    --     )
    --     vim.api.nvim_create_user_command('Rg',
    --         "call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%', 'alt-h'))",
    --         { nargs = '*' }
    --     )
    --     vim.api.nvim_create_user_command('Files',
    --         "call fzf#vim#files(<q-args>, fzf#vim#with_preview('right:50%', 'alt-h'))",
    --         { nargs = '*', complete = 'dir' }
    --     )
    --     vim.keymap.set('n', '<C-o>', '<cmd>Files<cr>')
    --
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

    -- In-line hints
    -- Plug 'simrat39/inlay-hints.nvim'

    -- Pretty debugging
    -- Plug 'folke/trouble.nvim'
        -- vim.keymap.set('n', '<C-t>', '<cmd>TroubleToggle<cr>')
        -- vim.keymap.set('n', '<leader>tq', '<cmd>TroubleToggle quickfix<cr>')
        -- vim.keymap.set('n', '<leader>tl', '<cmd>TroubleToggle loclist<cr>')
        -- vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>')
        -- vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle lsp_document_diagnostics<cr>')
        --nnoremap gR <cmd>TroubleToggle lsp_references<cr>
    Plug 'mfussenegger/nvim-dap'
        vim.keymap.set('n', '<leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
        vim.keymap.set('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>")
        vim.keymap.set('n', '<leader>dso', "<cmd>lua require'dap'.step_over()<cr>")
        vim.keymap.set('n', '<leader>dsi', "<cmd>lua require'dap'.step_into()<cr>")
    Plug 'rcarriga/nvim-dap-ui'

    -- Markdown
    Plug 'davidgranstrom/nvim-markdown-preview'

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

    -- Folding
    Plug 'kevinhwang91/nvim-ufo'
    Plug 'kevinhwang91/promise-async'

    -- Rust
    Plug('saecki/crates.nvim', {tag = '*'})

    -- Mail
    --Plug('soywod/himalaya', {rtp = 'vim'})

    -- Note-taking
    Plug 'vimwiki/vimwiki'
    Plug 'tools-life/taskwiki'
vim.call('plug#end')
