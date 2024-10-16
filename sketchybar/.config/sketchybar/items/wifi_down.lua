local colors = require("config.colors")

local wifi_down = sbar.add("item", "wifi.down", {
  position = "right",
  padding_left = -8,
  background = {
    drawing = false,
  },
  icon = {
    padding_right = 0,
    string = "􀓃",
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
  y_offset = -3,
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
