return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = true,
  config = function()
    local has_lualine, lualine = pcall(require, "lualine")
    if not has_lualine then
      return
    end

    lualine.setup({
      options = {
        theme = "catppuccin",
      },
    })
  end,
}
