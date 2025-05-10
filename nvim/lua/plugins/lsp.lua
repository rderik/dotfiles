require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "tsserver" },
}

local lsp = require("lspconfig")
for _, srv in ipairs(require("mason-lspconfig").get_installed_servers()) do
  lsp[srv].setup({
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end

-- nvim‑cmp
local cmp = require("cmp")
cmp.setup {
  snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
  }),
  sources = { { name = "nvim_lsp" }, { name = "path" }, { name = "luasnip" } },
}

