-- Comment
require('Comment').setup()

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

-- Indent-blankline
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

-- Hop
require'hop'.setup()
vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_words()<cr>", {})

-- Colorizer
require'colorizer'.setup()

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
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

-- Lualine
-- Get count of search matches
vim.o.shortmess = vim.o.shortmess .. "S"

local function search_count()
	if vim.api.nvim_get_vvar("hlsearch") == 1 then
		local res = vim.fn.searchcount({ maxcount = 999, timeout = 500 })

		if res.total > 0 then
			return string.format("%d/%d", res.current, res.total)
		end
	end

	return ""
end

require('lualine').setup {
    options = {
        theme = 'ayu_mirage',
    },
	sections = {
		lualine_b = { { search_count, type = "lua_expr" } },
	},
}

-- nvim-tree
require('nvim-tree').setup {
    -- auto_close = true,
}

-- Trouble
require('trouble').setup {
    auto_open = true,
    auto_fold = false,
    use_diagnostic_signs = true,
}

-- Todo comments
require("todo-comments").setup()

-- which-key
require('which-key').setup()

-- Rust
require('rust-tools').setup {
    tools = { -- rust tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
}

require('crates').setup()
