local map = vim.keymap.set
local copy_keymap = function(mode, cur_lhs, new_lhs)
  local map_data = vim.fn.maparg(cur_lhs, mode, false, true)
  map_data.lhs, map_data.lhsraw = new_lhs, vim.keycode(new_lhs)
  vim.fn.mapset(map_data)
end

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Clear highlights on search when pressing <Esc> in normal mode
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights on search when pressing <Esc> in normal mode" })

map("n", "<C-S-b>", "<cmd>source %<CR>", { desc = "Source current file" })
map("n", "<C-b>", ":.lua<CR>", { desc = "Source current line" })
map("v", "<C-b>", ":lua<CR>", { desc = "Source current selection" })

--  Use CTRL+<hjkl> to switch between windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<leader>nn", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>nr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- nvimtree
-- map("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "toggle NvimTree" })
-- map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- oil
map("n", "-", "<cmd>Oil<CR>", { desc = "Oil: Open parent directory" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- splits
map("n", "<leader>hh", "<cmd>sp<CR>", { desc = "horizontal split" })
map("n", "<leader>hv", "<cmd>vsp<CR>", { desc = "vertical split" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "close buffer/split" })

-- buffers
-- map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "move to next buffer" })
-- map("n", "<S-Tab>", "<cmd>bprev<CR>", { desc = "move to prev buffer" })
map({ "i", "n" }, "<C-s>", "<cmd>w!<cr>", { desc = "Save buffer" })
map({ "i", "n" }, "<C-q>", "<cmd>q!<cr>", { desc = "Quit buffer" })
map({ "i", "n" }, "<C-z>", "u", { desc = "Undo" })

-- indents
map("n", "<lt>", "<lt><lt>", { silent = true, desc = "Outdent" })
map("n", ">", ">>", { silent = true, desc = "Indent" })
map("v", "<lt>", "<lt>gv", { silent = true, desc = "Outdent" })
map("v", ">", ">gv", { silent = true, desc = "Indent" })
map("v", "<S-Tab>", "<lt>gv", { silent = true, desc = "Outdent" })
map("v", "<Tab>", ">gv", { silent = true, desc = "Indent" })

-- quickfix
map("n", "<leader>fo", "<cmd>copen<CR>", { desc = "Open Quickfix window" })
map("n", "<leader>fc", "<cmd>cclose<CR>", { desc = "Close Quickfix window" })
map("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Move to next Quickfix entry" })
map("n", "<C-p>", "<cmd>cprev<CR>", { desc = "Move to prev Quickfix entry" })

-- Diagnostic keymaps
-- map("n", "<leader>fd", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic Quick[F]ix list" })
map("n", "<leader>fd", vim.diagnostic.setqflist, { desc = "Open [D]iagnostic Quick[F]ix list" })
map("n", "<leader>diaf", vim.diagnostic.open_float)
map("n", "<leader>diap", vim.diagnostic.goto_prev)
map("n", "<leader>dian", vim.diagnostic.goto_next)
map("n", "<leader>diat", "<cmd>Telescope diagnostics<cr>")

-- terminal
-- local job_id = 0
map("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
  -- job_id = vim.bo.channel
end, { desc = "Open terminal" })
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- comments
copy_keymap("n", "gcc", "<C-/>")
copy_keymap("v", "gc", "<C-/>")

-- markdown
map("n", "<leader>md", "<cmd>MarkdownPreview<CR>", { desc = "Start Markdown Preview in a browser" })

-- greeter
map("n", "<leader>na", "<cmd>Alpha<CR>", { desc = "Open Nvim Greeter" })

-- live preview
map("n", "<leader>lp", "<cmd>LivePreview start<CR>", { desc = "Open Live Preview" })
