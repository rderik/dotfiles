-- insert helper for “[project-ref]: # ()”
local M = {}

function M.project_tag()
  local tag = "[project-ref]: # ()"
  local row = vim.api.nvim_win_get_cursor(0)[1]   -- 1‑based
  -- insert three lines below current
  vim.api.nvim_buf_set_lines(0, row, row, false, { "", tag, "" })
  -- move cursor to the empty parens and enter insert‑mode
  vim.api.nvim_win_set_cursor(0, { row + 2, #tag })
  vim.cmd("startinsert")
end

return M
