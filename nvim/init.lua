print("[nvim] init.lua loaded")

vim.g.mapleader      = "\\"       -- must be set *before* plugins/keymaps load
vim.g.maplocalleader = "\\"

require("core.options")   -- <lua/core/options.lua>
require("core.keymaps")   -- <lua/core/keymaps.lua>
require("core.autocmds")  -- <lua/core/autocmds.lua>

-- Plugin manager
require("core.lazy")      -- <lua/core/lazy.lua>

vim.cmd.colorscheme("dracula")   -- pick your favourite

-- Provider tweaks (optional; speeds startup if you don't use LuaJIT FFI)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0
vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0

-- Misc quick opts
vim.opt.shortmess:append("c")     -- don’t pass messages to |ins-completion-menu|
vim.opt.formatoptions:remove({ "o", "r" })  -- stop continuing comments

-- Helper: reload this file without restarting Neovim
vim.api.nvim_create_user_command("ReloadInit", function()
  vim.cmd("source $MYVIMRC")
  print("init.lua reloaded!")
end, {})
