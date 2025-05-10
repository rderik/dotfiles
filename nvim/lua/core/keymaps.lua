vim.g.mapleader, vim.g.maplocalleader = "\\", "\\"
local k = vim.keymap.set
-- General
k("n", "<leader>ev", "<cmd>vs $MYVIMRC<cr>", { desc = "edit init.lua" })
k("n", "<leader>sv", "<cmd>so $MYVIMRC<cr>", { desc = "source init.lua" })
k("n", "<c-l>", "<cmd>nohlsearch<cr><c-l>")
-- Picker
k("n", "<leader>f",  "<cmd>Telescope find_files<cr>")
k("n", "<leader>b",  "<cmd>Telescope buffers<cr>")
-- File tree
k("n", "<c-n>", "<cmd>NvimTreeToggle<cr>")
-- Align
k({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
-- Zen / distraction‑free
k("n", "<leader>g", "<cmd>ZenMode<cr>")

local notes = require("user.notes")
vim.keymap.set("n", "<leader>st", notes.project_tag,
  { desc = "insert [project-ref]" })

