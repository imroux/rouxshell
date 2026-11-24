return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "diff",
          "html",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
          "javascript",
          "typescript",
          "html",
          "css",
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>ts",
            node_incremental = "<leader>ti",
            scope_incremental = "<leader>tc",
            node_decremental = "<leader>td",
          },
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ---@diagnostic disable-next-line: missing-fields
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            ---@diagnostic disable-next-line: missing-fields
            -- * query_string: eg '@function.inner'
            ---@diagnostic disable-next-line: missing-fields
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ---@diagnostic disable-next-line: missing-fields
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            ---@diagnostic disable-next-line: missing-fields
            -- * query_string: eg '@function.inner'
            ---@diagnostic disable-next-line: missing-fields
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
      })
      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}
