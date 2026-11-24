return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {},
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        direction = "float",
        float_opts = {
          border = "single",
        },
      })
    end,
  },
}
