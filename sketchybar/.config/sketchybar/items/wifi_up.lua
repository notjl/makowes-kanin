local colors = require("config.colors")
local icons = require("config.icons")

sbar.exec("killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 4.0")

local wifi_up = sbar.add("item", "wifi.up", {
  position = "right",
  width = 0,
  y_offset = 6,
  icon = {
    padding_right = 0,
    string = icons.sf_symbol.wifi.upload,
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

wifi_up:subscribe("network_update", function(env)
  wifi_up:set({
    icon = {
      color = (env.upload == "000 Bps") and colors.subtext0 or colors.blue,
    },
    label = {
      string = env.upload,
      color = (env.upload == "000 Bps") and colors.subtext0 or colors.blue,
    }
  })
end)

return wifi_up
