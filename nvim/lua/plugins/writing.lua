-- lua/plugins/writing.lua
return {
  -------------------------------------------------------------------------
  --  …other writing helpers…
  -------------------------------------------------------------------------
  { "vimwiki/vimwiki",
    init = function()         -- runs before the plugin is actually loaded
      vim.g.vimwiki_list = { {
        path          = "/Users/derik/Documents/Personal/Notes/wiki/",
        path_html     = "/Users/derik/Documents/Personal/Notes/wiki_html",
        diary_rel_path= "Daily Notes/",
        diary_index   = "index",
        syntax        = "markdown",
        ext           = ".md",
      } }
    end,
  },
}
