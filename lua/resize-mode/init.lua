local h = require("resize-mode.helper")
local resize_mode = require("resize-mode.resize-mode")
local config = require("resize-mode.config")

local M = {}

M.setup = config.setup
M.start = resize_mode.start
M.end_mode = resize_mode.end_mode

-- Moving a border = resizing the window on the far side of it. Resizing the
-- left/top neighbour moves the left/top border, resizing the current window
-- moves the right/bottom border.

---@param amount integer
M.increase_left = function(amount)
  local left = h.neighbour("h")
  if left then
    h.add_width(left, -amount)
  end
end

---@param amount integer
M.decrease_left = function(amount)
  local left = h.neighbour("h")
  if left then
    h.add_width(left, amount)
  end
end

---@param amount integer
M.increase_right = function(amount)
  if h.neighbour("l") then
    h.add_width(0, amount)
  end
end

---@param amount integer
M.decrease_right = function(amount)
  if h.neighbour("l") then
    h.add_width(0, -amount)
  end
end

---@param amount integer
M.increase_top = function(amount)
  local up = h.neighbour("k")
  if up then
    h.add_height(up, -amount)
  end
end

---@param amount integer
M.decrease_top = function(amount)
  local up = h.neighbour("k")
  if up then
    h.add_height(up, amount)
  end
end

---@param amount integer
M.increase_bottom = function(amount)
  if h.neighbour("j") then
    h.add_height(0, amount)
  end
end

---@param amount integer
M.decrease_bottom = function(amount)
  if h.neighbour("j") then
    h.add_height(0, -amount)
  end
end

return M
