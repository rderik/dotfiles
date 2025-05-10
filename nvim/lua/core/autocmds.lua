local aug = vim.api.nvim_create_augroup
local ac  = vim.api.nvim_create_autocmd

-- highlight extra whitespace
ac({ "BufReadPost", "InsertLeave" }, {
  pattern = "*",
  group = aug("trim", {}),
  callback = function() vim.cmd.match("ExtraWhitespace", [[\s\+$]]) end,
})

-- per‑filetype tweaks
ac("FileType", {
  pattern = "markdown",
  group = aug("ft_markdown", {}),
  callback = function()
    vim.keymap.set("n", "<localleader>d",
      function()
        vim.fn.append(".", "# " .. os.date("%Y-%m-%d %A"))
      end, { buffer = true, desc = "insert journal header" })
  end,
})

-- resize splits after Neovim window is resized (tmux friendly)
ac("VimResized", { pattern = "*", command = "wincmd =" })
