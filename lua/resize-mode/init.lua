local h = require("resize-mode.helper")
local resize_mode = require("resize-mode.resize-mode")
local config = require("resize-mode.config")

local M = {}

M.setup = config.setup
M.start = resize_mode.start

M.increase_left = function(amount)
  if h.at_left_edge() then
    return
  end

  local cmd
  if h.at_right_edge() then
    cmd = h.vinc(amount)
  else
    cmd = h.wrap_in_move("h", "l", h.vdec(amount))
  end

  h.feed_keys(cmd)
end

M.decrease_left = function(amount)
  if h.at_left_edge() then
    return
  end

  local cmd
  if h.at_right_edge() then
    cmd = h.vdec(amount)
  else
    cmd = h.wrap_in_move("h", "l", h.vinc(amount))
  end

  h.feed_keys(cmd)
end

M.increase_right = function(amount)
  if h.at_right_edge() then
    return
  end

  local cmd = h.vinc(amount)
  h.feed_keys(cmd)
end

M.decrease_right = function(amount)
  if h.at_right_edge() then
    return
  end

  local cmd = h.vdec(amount)
  h.feed_keys(cmd)
end

M.increase_top = function(amount)
  if h.at_top_edge() then
    return
  end

  local cmd
  if h.at_bottom_edge() then
    cmd = h.hinc(amount)
  else
    cmd = h.wrap_in_move("k", "j", h.hdec(amount))
  end

  h.feed_keys(cmd)
end

M.decrease_top = function(amount)
  if h.at_top_edge() then
    return
  end

  local cmd
  if h.at_bottom_edge() then
    cmd = h.hdec(amount)
  else
    cmd = h.wrap_in_move("k", "j", h.hinc(amount))
  end

  h.feed_keys(cmd)
end

M.increase_bottom = function(amount)
  if h.at_bottom_edge() then
    return
  end

  local cmd = h.hinc(amount)
  h.feed_keys(cmd)
end

M.decrease_bottom = function(amount)
  if h.at_bottom_edge() then
    return
  end

  local cmd = h.hdec(amount)
  h.feed_keys(cmd)
end

return M
