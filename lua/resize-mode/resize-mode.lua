local M = {}

local config = require("resize-mode.config")

---@class ResizeModeState
---@field hide? fun() restores the indicator, set while the mode is active
local state = {}

---@return table<string, fun()> keycode -> resize action
local function actions()
  local rm = require("resize-mode")
  local hz, v = config.horizontal_amount, config.vertical_amount
  local k = config.resize_keys
  return {
    [vim.keycode(k[1])] = function()
      rm.increase_left(hz)
    end,
    [vim.keycode(k[2])] = function()
      rm.increase_bottom(v)
    end,
    [vim.keycode(k[3])] = function()
      rm.increase_top(v)
    end,
    [vim.keycode(k[4])] = function()
      rm.increase_right(hz)
    end,
    [vim.keycode(k[5])] = function()
      rm.decrease_left(hz)
    end,
    [vim.keycode(k[6])] = function()
      rm.decrease_bottom(v)
    end,
    [vim.keycode(k[7])] = function()
      rm.decrease_top(v)
    end,
    [vim.keycode(k[8])] = function()
      rm.decrease_right(hz)
    end,
  }
end

---Tint the window + show the mode label, returns the restore fn
---@param win integer
---@return fun()
local function show_indicator(win)
  local indicator = config.indicator
  if not indicator then
    return function() end
  end

  vim.api.nvim_set_hl(0, indicator.hl_group, { link = "CursorLine", default = true })
  local previous = vim.wo[win].winhighlight
  local tint = "Normal:" .. indicator.hl_group
  vim.wo[win].winhighlight = previous == "" and tint or previous .. "," .. tint
  vim.api.nvim_echo({ { indicator.label, "ModeMsg" } }, false, {})

  return function()
    if vim.api.nvim_win_is_valid(win) then
      vim.wo[win].winhighlight = previous
    end
    vim.api.nvim_echo({}, false, {})
  end
end

---Read keys until a non-resize key. Returns that key unless it is the quit key.
---@return string?
local function run_loop()
  local keys = actions()
  local quit = vim.keycode(config.quit_key)

  while true do
    vim.cmd.redraw()
    -- <C-c> raises "Keyboard interrupt" inside getcharstr
    local ok, key = pcall(vim.fn.getcharstr)
    if not ok then
      return nil
    end

    local action = keys[key]
    if not action then
      return key ~= quit and key or nil
    end
    action()
  end
end

function M.start()
  if vim.fn.mode() ~= "n" then
    vim.notify("Resize mode must be triggered from normal mode", vim.log.levels.ERROR)
    return
  end
  if state.hide then
    return
  end

  state.hide = show_indicator(vim.api.nvim_get_current_win())
  if config.hooks.on_enter then
    config.hooks.on_enter()
  end

  -- enable_mapping = false: the caller drives the mode and calls end_mode()
  if not config.enable_mapping then
    return
  end

  local leftover = run_loop()
  M.end_mode()
  if leftover then
    vim.api.nvim_feedkeys(leftover, "m", false)
  end
end

function M.end_mode()
  if not state.hide then
    return
  end
  state.hide()
  state.hide = nil

  if config.hooks.on_leave then
    config.hooks.on_leave()
  end
end

return M
