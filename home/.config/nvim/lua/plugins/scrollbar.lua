return {
  {
    "dstein64/nvim-scrollview",
    coroutineonfig = function()
      require("scrollview").setup({
        excluded_filetypes = { "nerdtree" },
        current_only = true,
        base = "buffer",
        -- column = 80,
        signs_on_startup = { "all" },
        diagnostics_severities = { vim.diagnostic.severity.ERROR },
      })
    end,
  },
}
