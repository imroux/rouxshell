return {
  "ya2s/nvim-cursorline",
  enabled = true,
  config = function()
    require("nvim-cursorline").setup({
      cursorline = {
        enable = true,
        timeout = 1500,
        number = true,
      },
      cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
      },
    })
  end,
}
