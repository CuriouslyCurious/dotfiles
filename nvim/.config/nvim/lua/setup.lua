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

-- Folding
require('ufo').setup {
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
}

-- Enable all the mini goodies
require('mini.ai').setup()
require('mini.align').setup()
--require('mini.animate').setup()
--require('mini.base16').setup()
--require('mini.basics').setup()
require('mini.bracketed').setup()
require('mini.bufremove').setup()
require('mini.clue').setup {
    triggers = {
       -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        -- { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        require('mini.clue').gen_clues.builtin_completion(),
        require('mini.clue').gen_clues.g(),
        require('mini.clue').gen_clues.marks(),
        require('mini.clue').gen_clues.registers(),
        require('mini.clue').gen_clues.windows(),
        require('mini.clue').gen_clues.z(),
    },
}
require('mini.colors').setup()
require('mini.comment').setup()
-- require('mini.completion').setup()
require('mini.cursorword').setup {
    delay = 200,
}
--require('mini.doc').setup()
require('mini.files').setup {
    options = {
        permanent_delete = false,
    },
}
local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
end
vim.keymap.set('n', '<C-o>', minifiles_toggle)

local map_split = function(buf_id, lhs, direction)
local rhs = function()
  -- Make new window and set it as target
  local new_target_window
  vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
    vim.cmd(direction .. ' split')
    new_target_window = vim.api.nvim_get_current_win()
  end)

  MiniFiles.set_target_window(new_target_window)
end

-- Adding `desc` will result into `show_help` entries
local desc = 'Split ' .. direction
vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak keys to your liking
        map_split(buf_id, 'gs', 'belowright horizontal')
        map_split(buf_id, 'gv', 'belowright vertical')
    end,
})

require('mini.fuzzy').setup {
    cutoff = 200,
}
require('mini.hipatterns').setup {
    highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE', 'SAFETY', 'PERF'
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
        todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
        note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
        perf = { pattern = '%f[%w]()PERF()%f[%W]',  group = 'MiniHipatternsPerf'  },
        safety = { pattern = '%f[%w]()SAFETY()%f[%W]',  group = 'MiniHipatternsSafety'  },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
    },
}
-- require('mini.hues').setup {
--     background = '#1f292d',
--     foreground = '#cdd3de',
-- }
require('mini.indentscope').setup {
    draw = {
        delay = 200,
        animation = require('mini.indentscope').gen_animation.none()
        -- indentscope.gen_animation.linear({
        --     duration = 0,
        --     unit = 'step',
        -- }),
    }
}
require('mini.jump').setup()
--require('mini.jump2d').setup()
local map = require('mini.map')
map.setup{
    integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
    },
    symbols = {
        encode = require('mini.map').gen_encode_symbols.dot('4x2'),
    },
    window = {
        show_integration_count = false,
    }
}
--require('mini.misc').setup()
require('mini.move').setup()
require('mini.operators').setup()
require('mini.pairs').setup {
    -- In which modes mappings from this `config` should be created
    modes = { insert = true, command = false, terminal = false },

    -- Global mappings. Each right hand side should be a pair information, a
    -- table with at least these fields (see more in |MiniPairs.map|):
    -- - <action> - one of 'open', 'close', 'closeopen'.
    -- - <pair> - two character string for pair to be used.
    -- By default pair is not inserted after `\`, quotes are not recognized by
    -- `<CR>`, `'` does not insert pair after a letter.
    -- Only parts of tables can be tweaked (others will use these defaults).
    mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
        ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },

        [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
        [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
        ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
        ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },

        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
    },
}
require('mini.sessions').setup()
require('mini.splitjoin').setup()
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
-- require('nvim-tree').setup()

-- Enable inlay hints
-- require('inlay-hints').setup {
--     only_current_line = true,
--
--     eol = {
--         right_align = true,
--     }
-- }

-- Trouble
-- require('trouble').setup {
--    auto_open = true,
--    auto_close = true,
--    auto_fold = false,
--    use_diagnostic_signs = true,
-- }



-- Cargo.toml fancying
require('crates').setup()

-- vimwiki
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.vimwiki_list = {{path = '~/vimwiki', syntax = 'markdown', ext = '.md'}}
vim.g.vimwiki_markdown_link_ext = 1
vim.api.nvim_set_var('vimwiki_global_ext', 0)
vim.g.taskwiki_markup_syntax = 'markdown'

-- Telescope
local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<C-o>', builtin.find_files, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Theme
-- require("catppuccin").setup {
--     flavour = "mocha",
--     integrations = {
--         cmp = true,
--         dap = {
--             enabled = true,
--             enable_ui = true,
--         },
--         gitsigns = true,
--         markdown = true,
--         mini = true,
--         nvimtree = true,
--         treesitter = true,
--         ufo = true,
--         vimwiki = true,
--     }
-- }
-- require('tokyonight').setup()
-- vim.cmd.colorscheme 'tokyonight-night'
vim.cmd.colorscheme 'material-monokai'
