return {
  "nomnivore/ollama.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- All the user commands added by the plugin
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

  keys = {
    -- Sample keybinds for prompt menu. Note that the <c-u> is important for selections to work properly.
    { "<leader>o", nil, desc = "AI/Ollama" },
    {
      "<leader>oo",
      ":<c-u>lua require('ollama').prompt()<cr>",
      desc = "ollama prompt",
      mode = { "n", "v" },
    },
    {
      "<leader>om",
      ":OllamaModel<cr>",
      desc = "ollama model",
      mode = { "n", "v" },
    },

    -- Sample keybinds for direct prompting. Note that the <c-u> is important for selections to work properly.
    {
      "<leader>og",
      ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
      desc = "ollama Generate Code",
      mode = { "n", "v" },
    },
    {
      "<leader>oe",
      ":<c-u>lua require('ollama').prompt('Explain_Code')<cr>",
      desc = "ollama Explain Code",
      mode = { "n", "v" },
    },
  },

  ---@type Ollama.Config
  opts = {
    model = "qwen3-coder-next:cloud",
  },
}
