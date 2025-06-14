return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        -- Move to previous/next
        map('n', '<C-h>', '<Cmd>BufferPrevious<CR>', opts)
        map('n', '<C-l>', '<Cmd>BufferNext<CR>', opts)

        -- Re-order to previous/next
        map('n', '<C-A-H>', '<Cmd>BufferMovePrevious<CR>', opts)
        map('n', '<C-A-L>', '<Cmd>BufferMoveNext<CR>', opts)

        -- Goto buffer in position...
        map('n', '<C-1>', '<Cmd>BufferGoto 1<CR>', opts)
        map('n', '<C-2>', '<Cmd>BufferGoto 2<CR>', opts)
        map('n', '<C-3>', '<Cmd>BufferGoto 3<CR>', opts)
        map('n', '<C-4>', '<Cmd>BufferGoto 4<CR>', opts)
        map('n', '<C-5>', '<Cmd>BufferGoto 5<CR>', opts)
        map('n', '<C-6>', '<Cmd>BufferGoto 6<CR>', opts)
        map('n', '<C-7>', '<Cmd>BufferGoto 7<CR>', opts)
        map('n', '<C-8>', '<Cmd>BufferGoto 8<CR>', opts)
        map('n', '<C-9>', '<Cmd>BufferGoto 9<CR>', opts)
        map('n', '<C-0>', '<Cmd>BufferLast<CR>', opts)

        -- Pin/unpin buffer
        map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

        -- Goto pinned/unpinned buffer
        --                 :BufferGotoPinned
        --                 :BufferGotoUnpinned

        -- Close buffer
        map('n', '<C-c>', '<Cmd>BufferClose<CR>', opts)

        -- Wipeout buffer
        --                 :BufferWipeout

        -- Close commands
        --                 :BufferCloseAllButCurrent
        --                 :BufferCloseAllButPinned
        --                 :BufferCloseAllButCurrentOrPinned
        --                 :BufferCloseBuffersLeft
        --                 :BufferCloseBuffersRight

        -- Magic buffer-picking mode
        map('n', '<C-p>',   '<Cmd>BufferPick<CR>', opts)
        map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', opts)

        -- Sort automatically by...
        map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
        map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
        map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
        map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
        map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

        -- Other:
        -- :BarbarEnable - enables barbar (enabled by default)
        -- :BarbarDisable - very bad command, should never be used
    end
}
