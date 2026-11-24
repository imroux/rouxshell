return {
  "lukas-reineke/virt-column.nvim",
  opts = {},
  config = function()
    require("virt-column").setup({
      enabled = true,
      virtcolumn = "81, 121",
    })
  end,
}
