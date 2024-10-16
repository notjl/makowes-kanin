local wifi_up = require("items.wifi_up")
local wifi_down = require("items.wifi_down")
local colors = require("config.colors")

local wifi = sbar.add("item", "wifi", {
  position = "right",
  padding_right = 8,
  width = 0,
  icon = {
    padding_right = 0,
  },
  label = {
    drawing = false,
  },
})

local wifi_bracket = sbar.add("bracket", "wifi.bracket", {
  "wifi",
  "wifi.up",
  "wifi.down",
}, {
  background = {
    height = 35
  },
})

local function hide_load_detail()
  wifi_down:set({
    icon = {
      width = 0
    },
    label = {
      width = 0
    }
  })
  wifi_up:set({
    icon = {
      width = 0
    },
    label = {
      width = 0
    }
  })
  wifi:set({ icon = { padding_right = 8 } })
  wifi_bracket:set({ background = { height = 28 } })
end

hide_load_detail()

wifi:subscribe({"wifi_change", "system_woke"}, function(env)
  sbar.exec("ipconfig getifaddr en0", function(ip)
    local connected = not (ip == "")
    wifi:set({
      icon = {
        string = connected and "󰖩" or "󰖪",
        color = colors.white,
      },
    })
    wifi_bracket:set({
      background = {
        border_color = connected and colors.change_alpha(colors.white, 0.6) or colors.red,
      }
    })
  end)
end)

local function show_load_detail()
  wifi_down:set({
    icon = {
      width = "dynamic"
    },
    label = {
      width = "dynamic"
    }
  })
  wifi_up:set({
    icon = {
      width = "dynamic"
    },
    label = {
      width = "dynamic"
    }
  })
  wifi:set({ icon = { padding_right = 0 } })
  wifi_bracket:set({ background = { height = 35 } })
end

local function toggle_load_detail()
  local should_draw = wifi_down:query().icon.width == 0
  if should_draw then
    sbar.animate("tanh", 25, show_load_detail)
  else
    sbar.animate("tanh", 25, hide_load_detail)
  end
end

wifi:subscribe("mouse.clicked", toggle_load_detail)
wifi_up:subscribe("mouse.clicked", toggle_load_detail)
wifi_down:subscribe("mouse.clicked", toggle_load_detail)