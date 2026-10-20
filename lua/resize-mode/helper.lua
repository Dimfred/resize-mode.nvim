local M = {}

---Window next to the current one, nil at the edge
---@param dir "h"|"j"|"k"|"l"
---@return integer?
M.neighbour = function(dir)
  local nr = vim.fn.winnr(dir)
  if nr == vim.fn.winnr() then
    return nil
  end
  return vim.fn.win_getid(nr)
end

---@param win integer
---@param delta integer
M.add_width = function(win, delta)
  vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + delta)
end

---@param win integer
---@param delta integer
M.add_height = function(win, delta)
  vim.api.nvim_win_set_height(win, vim.api.nvim_win_get_height(win) + delta)
end

return M
