local colors = require("config.colors")
local icons = require("config.icons")

local batt_icon = icons.nerd_font.battery

local bracket_space = sbar.add("item", {
  position = "right",
  width = 8,
  background = { drawing = false },
})

local remaining = sbar.add("item", "battery.remaining", {
  position = "right",
  y_offset = -3,
  width = 0,
  icon = { drawing = false },
  background  = { drawing = false },
  label = {
    font = { size = 13.0 },
  },
})

local battery = sbar.add("item", "battery", {
  position = "right",
  padding_right = 4,
  update_freq = 1,
  background  = { drawing = false },
  icon = {
    padding_left = 12,
  },
})

local battery_bracket = sbar.add("bracket", "battery.bracket", {
  "battery.remaining",
  "battery",
}, { 
  background = { height = 35 },
})

local function hide_remaining()
  battery_bracket:set({ background = { height = 28 } })
  remaining:set({ label = { width = 0 } })
  battery:set({
    label = {
      y_offset = 0,
      padding_left = 4,
      font = {
        size = 15.0,
      },
    },
  })
end

hide_remaining()


battery:subscribe({"routine", "power_source_charge", "system_woke"}, function()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = "?"
    local border_color = nil

    local found, _, charge = batt_info:find("(%d+)%%")
    local found_rem, _, remaining_str = batt_info:find(" (%d+:%d+) remaining")
    local charging, _, _ = batt_info:find("AC Power")

    -- local remaining_label = "2:20H"
    local remaining_label = found_rem and remaining_str .. "H" or "--:--"

    if found then
      charge = tonumber(charge)
      label = charge .. "%"
      label = (charge < 10) and "0" .. label or label

      local icon_base = charging and batt_icon.charging or batt_icon
      local charge_index = "_" .. math.floor(charge / 10) * 10
      icon = icon_base[charge_index]

      if charge > 30 then
        border_color = colors.change_alpha(colors.green, 0.8)
      elseif charge > 20 then
        border_color = colors.change_alpha(colors.yellow, 0.8)
      elseif charge > 10 then
        border_color = colors.change_alpha(colors.peach, 0.8)
      elseif charge > 1 then
        border_color = colors.change_alpha(colors.red, 0.8)
      end
    end

    battery_bracket:set({ background = { border_color = border_color } })
    battery:set({
      icon = { string = icon },
      label = { string = label },
    })
    remaining:set({ label = { string = remaining_label } })
  end)
end)

local function show_remaining()
  battery_bracket:set({ background = { height = 35 } })
  remaining:set({ label = { width = "dynamic" } })
  battery:set({
    label = {
      y_offset = 6,
      padding_left = 24,
      font = {
        size = 13.0,
      },
    },
  })
end

local function toggle_remaining()
  local should_draw = remaining:query().label.width == 0
  if should_draw then
    sbar.animate("tanh", 25, show_remaining)
  else
    sbar.animate("tanh", 25, hide_remaining)
  end
end

battery:subscribe("mouse.clicked", toggle_remaining)
remaining:subscribe("mouse.clicked", toggle_remaining)
