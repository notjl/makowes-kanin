local colors = require("config.colors")
local icons = require("config.icons")

local wifi_down = sbar.add("item", "wifi.down", {
  position = "right",
  padding_left = -8,
  y_offset = -3,
  background = {
    drawing = false,
  },
  icon = {
    padding_right = 0,
    string = icons.sf_symbol.wifi.download,
    font = {
      size = 12.0
    },
  },
  label = {
    string = "??? Bps",
    font = {
      size = 13.0
    },
  },
})

wifi_down:subscribe("network_update", function(env)
  wifi_down:set({
    icon = {
      color = (env.download == "000 Bps") and colors.subtext0 or colors.green,
    },
    label = {
      string = env.download,
      color = (env.download == "000 Bps") and colors.subtext0 or colors.green,
    }
  })
end)

return wifi_down
