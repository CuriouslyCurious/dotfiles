-- Treesitter setup
require('nvim-treesitter.configs').setup {
    ensure_installed = { "rust", "python", "c", "cpp" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        --[ custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        --  ["foo.bar"] = "Identifier",
        --},
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = '<CR>',
            scope_incremental = '<CR>',
            node_incremental = '<TAB>',
            node_decremental = '<S-TAB>',
        }
    },
    -- Experimental indentation based on treesitter
    indent = {
        enable = false
    },
    -- autopairs = {
    --     enable = true
    -- },
}


-- Enable all the mini goodies
--require('mini.ai').setup()
require('mini.align').setup()
--require('mini.base16').setup()
--require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.cursorword').setup()
--require('mini.doc').setup()
--require('mini.fuzzy').setup()
require('mini.indentscope').setup()
require('mini.jump').setup()
--require('mini.jump2d').setup()
--require('mini.misc').setup()
require('mini.pairs').setup()
require('mini.sessions').setup()
require('mini.starter').setup()
vim.o.shortmess = vim.o.shortmess .. "S"
require('mini.statusline').setup {
    content = {
        active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local git           = MiniStatusline.section_git({ trunc_width = 75 })
            local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75, icon = "" })
            local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
            -- Add searchcount to the statusline
            local searchcount   = MiniStatusline.section_searchcount({ trunc_width = 75, recompute = false })
            local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            local location      = MiniStatusline.section_location({ trunc_width = 75 })

            return MiniStatusline.combine_groups({
                { hl = mode_hl,                  strings = { mode } },
                { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics, lspstatus } },
                '%<', -- Mark general truncate point
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                '%=', -- End left alignment
                { hl = 'MiniStatuslineFileinfo', strings = { searchcount, fileinfo } },
                { hl = mode_hl,                  strings = { location } },
            })
        end
    }
}
require('mini.surround').setup()
require('mini.tabline').setup()
--require('mini.test').setup()
require('mini.trailspace').setup()

-- Colorize hex codes and names
require('colorizer').setup()

-- Todo comments
require("todo-comments").setup()

-- nvim-autopairs
--require('nvim-autopairs').setup{
--    disable_filetype = { "TelescopePrompt" },
--    enable_check_bracket_line = false,
--    check_ts = true,
--}
--
--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


-- Gitsigns
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
}

-- nvim-tree
require('nvim-tree').setup()

-- Enable inlay hints
require('inlay-hints').setup {
    only_current_line = true,

    eol = {
        right_align = true,
    }
}

-- Trouble
--require('trouble').setup {
--    auto_open = true,
--    auto_fold = false,
--    use_diagnostic_signs = true,
--}

-- Cargo.toml fancying
require('crates').setup()

-- Lualine
--require('lualine').setup {
--    options = {
--        theme = 'ayu_mirage',
--    },
--	sections = {
--		lualine_b = { { search_count, type = "lua_expr" } },
--	},
--}

-- which-key
--require('which-key').setup()

-- Rust
--require('rust-tools').setup {
--    tools = { -- rust tools options
--        autoSetHints = true,
--        inlay_hints = {
--            show_parameter_hints = false,
--            parameter_hints_prefix = "",
--            other_hints_prefix = "",
--        },
--    },
--}

-- Hop
--require'hop'.setup()
--vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})

