M = {}

----------------------------------------------------------------------
-- UTILITY
M.at_top_edge = function()
  return vim.fn.winnr() == vim.fn.winnr("k")
end

M.at_bottom_edge = function()
  return vim.fn.winnr() == vim.fn.winnr("j")
end

M.at_left_edge = function()
  return vim.fn.winnr() == vim.fn.winnr("h")
end

M.at_right_edge = function()
  return vim.fn.winnr() == vim.fn.winnr("l")
end

----------------------------------------------------------------------
-- COMMANDS
M.feed_keys = function(keys)
  local cmd = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(cmd, "m", true)
end

M.vinc = function(amount)
  return (":vertical resize +%s<CR>"):format(amount)
end

M.vdec = function(amount)
  return (":vertical resize -%s<CR>"):format(amount)
end

M.hinc = function(amount)
  return (":resize +%s<CR>"):format(amount)
end

M.hdec = function(amount)
  return (":resize -%s<CR>"):format(amount)
end

M.wrap_in_move = function(first_move, second_move, cmd)
  return ("<C-w>%s%s<C-w>%s"):format(first_move, cmd, second_move)
end

return M
