local colors = require("config.colors")
local icons = require("config.icons")

local batt_icon = icons.nerd_font.battery

local battery = sbar.add("item", "battery", {
  position = "right",
  padding_right = 8,
  update_freq = 1,
  icon = {
    padding_left = 12,
  },
})

battery:subscribe({"routine", "power_source_charge", "system_woke"}, function()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = "?"
    local border_color = nil

    local found, _, charge = batt_info:find("(%d+)%%")
    local charging, _, _ = batt_info:find("AC Power")

    if found then
      charge = tonumber(charge)
      label = charge .. "%"
      label = (charge < 10) and "0" .. label or label

      local icon_base = charging and batt_icon.charging or batt_icon
      local charge_index = "_" .. math.floor(charge / 10) * 10
      icon = icon_base[charge_index]

      if charge > 30 then
        border_color = colors.change_alpha(colors.green, 0.6)
      elseif charge > 20 then
        border_color = colors.change_alpha(colors.yellow, 0.6)
      elseif charge > 10 then
        border_color = colors.change_alpha(colors.peach, 0.6)
      elseif charge > 1 then
        border_color = colors.change_alpha(colors.red, 0.6)
      end
    end

    battery:set({
      background = {
        border_color = border_color,
      },
      icon = {
        string = icon,
      },
      label = {
        string = label,
      },
    })
  end)
end)
