local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  ---------------------------------------------------------------
  -- 1. Quality‑of‑life (tpope + Lua re‑writes)
  { "lewis6991/gitsigns.nvim", event = "BufReadPre",
      opts = { signs = { add = "+", change = "~", delete = "_" } } },
  "tpope/vim-fugitive",   "tpope/vim-repeat",  "tpope/vim-surround",
  { "kylechui/nvim-surround", opts = {} },     -- Lua port
  "tpope/vim-unimpaired", "tpope/vim-speeddating",
  ---------------------------------------------------------------
  -- 2. Navigation / picker
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "nvim-tree/nvim-tree.lua", cmd = "NvimTreeToggle" },
  ---------------------------------------------------------------
  -- 3. UI
  "rebelot/kanagawa.nvim",   -- pick one theme; true‑colors -> no CsApprox
  { "nvim-lualine/lualine.nvim", opts = { theme = "dracula" } },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  ---------------------------------------------------------------
  -- 4. Editing helpers
  "junegunn/vim-easy-align",
  { "numToStr/Comment.nvim", opts = {} },  -- ← NerdCommenter replacement
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  "kshenoy/vim-signature",   -- marks in gutter (optional)
  ---------------------------------------------------------------
  -- 5. LSP / completion / snippets
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate" },
  "williamboman/mason-lspconfig.nvim",
  { "hrsh7th/nvim-cmp", dependencies = {
      "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip"} },
  { "j-hui/fidget.nvim", tag = "legacy", opts = {} },   -- LSP status
  ---------------------------------------------------------------
  -- 6. Treesitter (syntax, text‑objects, folding)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
      opts = { ensure_installed = "all", highlight = { enable = true } } },
  "nvim-treesitter/nvim-treesitter-textobjects",
  ---------------------------------------------------------------
  -- 7. Git, sessions, startup profiler
  "dinhhuy258/git.nvim",      -- open blame, diff in split
  { "rmagatti/auto-session", opts = {} },
  "dstein64/vim-startuptime",
  ---------------------------------------------------------------
  -- 8. Writing / markdown / org‑mode
  { "folke/zen-mode.nvim", cmd = "ZenMode" },   -- replacement for goyo.vim
  { "nvim-treesitter/nvim-treesitter-context" },
  { "AckslD/nvim-FeMaco.lua", ft = "markdown" }, -- fenced‑code block edit
  ---------------------------------------------------------------
  -- 9. Language‑specific extras
  { "simrat39/rust-tools.nvim", ft = "rust" },
  { "fatih/vim-go", ft = "go", build = ":GoUpdateBinaries" },
  { "leafgarland/typescript-vim", ft = { "typescript", "javascript" } },
})

