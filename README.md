# resize-mode.nvim

A resize mode for Neovim, which allows to resize the window into the direction you want.

## Install

[Packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use("dimfred/resize-mode.nvim")
```

## Configuration

```lua
require("resize-mode").setup {
  horizontal_amount = 9,
  vertical_amount = 5,
  quit_key = "<ESC>",
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

## Cudos

Cudos to @mrjones2014 [smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim), I used his resize mode.
