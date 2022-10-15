local M = {}

local config = require("resize-mode.config")

local function wrap_amount(f, amount)
  return function()
    f(amount)
  end
end

function M.start()
  if vim.fn.mode() ~= "n" then
    vim.notify("Resize mode must be triggered from normal mode", vim.log.levels.ERROR)
    return
  end

  pcall(config.hooks.on_enter)

  local resize_mode = require("resize-mode")
  vim.keymap.set(
    "n",
    config.resize_keys[1],
    wrap_amount(resize_mode.increase_left, config.horizontal_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[2],
    wrap_amount(resize_mode.increase_bottom, config.vertical_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[3],
    wrap_amount(resize_mode.increase_top, config.vertical_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[4],
    wrap_amount(resize_mode.increase_right, config.horizontal_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[5],
    wrap_amount(resize_mode.decrease_left, config.horizontal_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[6],
    wrap_amount(resize_mode.decrease_bottom, config.vertical_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[7],
    wrap_amount(resize_mode.decrease_top, config.vertical_amount),
    {silent = true}
  )
  vim.keymap.set(
    "n",
    config.resize_keys[8],
    wrap_amount(resize_mode.decrease_right, config.horizontal_amount),
    {silent = true}
  )
  vim.keymap.set("n", config.quit_key, M.end_mode, {silent = true})
end

function M.end_mode()
  vim.api.nvim_del_keymap("n", config.resize_keys[1])
  vim.api.nvim_del_keymap("n", config.resize_keys[2])
  vim.api.nvim_del_keymap("n", config.resize_keys[3])
  vim.api.nvim_del_keymap("n", config.resize_keys[4])
  vim.api.nvim_del_keymap("n", config.resize_keys[5])
  vim.api.nvim_del_keymap("n", config.resize_keys[6])
  vim.api.nvim_del_keymap("n", config.resize_keys[7])
  vim.api.nvim_del_keymap("n", config.resize_keys[8])
  vim.api.nvim_del_keymap("n", config.quit_key)

  pcall(config.hooks.on_leave)
end

return M
