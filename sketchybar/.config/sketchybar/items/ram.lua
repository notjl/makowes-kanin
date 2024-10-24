local icons = require("config.icons")
local colors = require("config.colors")

sbar.add("item", {
  position = "left",
  background = { drawing = false },
})

local ram = sbar.add("item", "memory.ram", {
  position = "left",
  width = 0,
  y_offset = 0,
  update_freq = 4,
  icon = {
    string = icons.nerd_font.memory.ram,
    padding_left = 12,
    font = { size = 15.0 },
  },
  label = {
    string = "???%",
    font = { size = 15.0 },
  },
})

return ram
