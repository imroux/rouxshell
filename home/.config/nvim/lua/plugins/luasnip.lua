return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      -- Keymaps
      vim.keymap.set("n", "<space><space>s", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>")
      -- vim.keymap.set({ "i", "s" }, "<Tab>", function()
      --   ls.jump(1)
      -- end, { silent = true, noremap = true })
      -- vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      --   ls.jump(-1)
      -- end, { silent = true, noremap = true })
      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })

      -- Load all snippets from the snippets directory
      -- require("snippets").setup()
    end,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    setup = function()
      require("cmp_luasnip").setup({})
    end,
  },
}
