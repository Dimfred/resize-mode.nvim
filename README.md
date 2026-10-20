# resize-mode.nvim

A resize mode for Neovim, which allows to resize the window into the direction you want.

While the mode is active, the resize keys move the borders of the current window. The quit key leaves the mode, any other key leaves it as well and is then executed as usual. The current window is tinted and `-- RESIZE --` is shown in the command line.

## Install

[vim.pack](https://neovim.io/doc/user/pack.html):

```lua
vim.pack.add({ "https://github.com/dimfred/resize-mode.nvim" })
```

## Configuration

```lua
require("resize-mode").setup {
  horizontal_amount = 9,
  vertical_amount = 5,
  quit_key = "<ESC>",
  enable_mapping = true, -- false: start() only shows the indicator + runs hooks, you drive the mode and call end_mode()
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
  indicator = { -- false to disable
    hl_group = "ResizeMode", -- defaults to a link to CursorLine
    label = "-- RESIZE --",
  },
  hooks = {
    on_enter = nil, -- called when entering resize mode
    on_leave = nil  -- called when leaving resize mode
  }
}
```

## Usage

```lua
vim.keymap.set("n", "<leader>rr", require("resize-mode").start)
```

Lua API:

```lua
local resize_mode = require("resize-mode")

resize_mode.start()
resize_mode.end_mode()

resize_mode.increase_left(<amount>)
resize_mode.increase_right(<amount>)
resize_mode.increase_top(<amount>)
resize_mode.increase_bottom(<amount>)

resize_mode.decrease_left(<amount>)
resize_mode.decrease_right(<amount>)
resize_mode.decrease_top(<amount>)
resize_mode.decrease_bottom(<amount>)
```

The resize functions work on their own, outside of the mode as well.

## Kudos

Kudos to @mrjones2014 [smart-split.nvim](https://github.com/mrjones2014/smart-splits.nvim), I used his resize mode.
