local M = {
  horizontal_amount = 9,
  vertical_amount = 5,
  quit_key = "<ESC>",
  enable_mapping = true,
  resize_keys = {"h", "j", "k", "l", "H", "J", "K", "L"},
  hooks = {
    on_enter = nil,
    on_leave = nil
  }
}

function M.setup(config)
  M.horizontal_amount = config.horizontal_amount or M.horizontal_amount
  M.vertical_amount = config.vertical_amount or M.vertical_amount
  M.quit_key = config.quit_key or M.quit_key
  if config.enable_mapping ~= nil then
    M.enable_mapping = config.enable_mapping
  end
  M.resize_keys = config.resize_keys or M.resize_keys
  if config.hooks ~= nil then
    M.hooks.on_enter = config.hooks.on_enter or M.hooks.on_enter
    M.hooks.on_leave = config.hooks.on_leave or M.hooks.on_leave
  end
end

return M
