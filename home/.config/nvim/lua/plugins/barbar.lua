return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  enabled = true,
  config = function()
    require("barbar").setup({
      "romgrk/barbar.nvim",
      init = function()
        vim.g.barbar_auto_setup = false
      end,
      opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
      },
      icons = {
        buffer_index = true,
        separator_at_end = false,
      },
      insert_at_end = true,
      version = "^1.0.0", -- optional: only update when a new 1.x version is released
    })
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Move to previous/next
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

    -- Re-order to previous/next
    map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
    map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

    -- Goto buffer in position...
    map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
    map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
    map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
    map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
    map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
    map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
    map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
    map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
    map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
    map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

    -- Pin/unpin buffer
    map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)

    -- Goto pinned/unpinned buffer
    --                 :BufferGotoPinned
    --                 :BufferGotoUnpinned

    -- Close buffer
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

    -- Wipeout buffer
    --                 :BufferWipeout

    -- Close commands
    --                 :BufferCloseAllButCurrent
    --                 :BufferCloseAllButPinned
    --                 :BufferCloseAllButCurrentOrPinned
    --                 :BufferCloseBuffersLeft
    --                 :BufferCloseBuffersRight

    -- Magic buffer-picking mode
    map("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
    map("n", "<C-s-p>", "<Cmd>BufferPickDelete<CR>", opts)

    -- Sort automatically by...
    map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
    map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", opts)
    map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
    map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
    map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

    -- Other:
    -- :BarbarEnable - enables barbar (enabled by default)
    -- :BarbarDisable - very bad command, should never be used
  end,
}
