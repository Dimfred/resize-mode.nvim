# resize-mode.nvim

A resize mode for Neovim, which allows to resize the window into the direction you want.

## Install

[Packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {"dimfred/resize-mode.nvim"}
```

## Configuration

```lua
require("resize-mode").setup {
  horizontal_amount = 9,
  vertical_amount = 5,
  quit_key = "<ESC>",
  enable_mapping = true,
  resize_keys = {
      "h", -- increase to the left
      "j", -- increase to the bottom
      "k", -- increase to the top
      "l", -- increase to the right
      "H", -- decrease to the left
      "J", -- decrease to the bottom
      "K", -- decrease to the top
      "L"  -- decrease to the right
  },
  hooks = {
    on_enter = nil, -- called when entering resize mode
    on_leave = nil  -- called when leaving resize mode
  }
}
```

## Usage

Lua API:

```lua
local resize_mode = require("resize-mode")

resize_mode.start()

resize_mode.increase_left(<amount>)
resize_mode.increase_right(<amount>)
resize_mode.increase_top(<amount>)
resize_mode.increase_bottom(<amount>)

resize_mode.decrease_left(<amount>)
resize_mode.decrease_right(<amount>)
resize_mode.decrease_bottom(<amount>)
resize_mode.decrease_down(<amount>)
```

## Hook usecase:

I use [vimpeccable](https://github.com/svermeulen/vimpeccable) to map my keys and my bindings break when this plugin maps by default.

```lua
local vimp = require("vimp")

require("resize-mode").setup {
  enable_mapping = false, -- disable default mappings
  hooks = {
    on_enter = function()
      local config = require("resize-mode.config")

      local function wrap_with_amount(f, amount)
        return function()
          f(amount)
        end
      end

      local c = {
        {"h", resize_mode.increase_left, config.horizontal_amount},
        {"j", resize_mode.increase_bottom, config.vertical_amount},
        {"k", resize_mode.increase_top, config.vertical_amount},
        {"l", resize_mode.increase_right, config.horizontal_amount},
        {"H", resize_mode.decrease_left, config.horizontal_amount},
        {"J", resize_mode.decrease_bottom, config.vertical_amount},
        {"K", resize_mode.decrease_top, config.vertical_amount},
        {"L", resize_mode.decrease_right, config.horizontal_amount}
      }
      for _, data in ipairs(c) do
        local key, f, amount = unpack(data)
        vimp.nnoremap({"override"}, key, wrap_with_amount(f, amount))
      end
      vimp.nnoremap({"override"}, config.quit_key, resize_mode.end_mode)
    end,
    on_leave = function()
      -- reload config here to reapply the overwritten bindings
    end
  }
}
```

## Kudos

Kudos to @mrjones2014 [smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim), I used his resize mode.
