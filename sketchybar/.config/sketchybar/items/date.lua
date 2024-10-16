local colors = require("config.colors")

local date = sbar.add("item", "date", {
  position = "right",
  padding_left = 8,
  update_freq = 60,
})

date:subscribe({"system_wake", "routine", "forced"}, function()
  local alpha = 0.45
  local days_color = {
    colors.change_alpha(colors.red, alpha),
    colors.change_alpha(colors.yellow, alpha),
    colors.change_alpha(colors.peach, alpha),
    colors.change_alpha(colors.green, alpha),
    colors.change_alpha(colors.blue, alpha),
    colors.change_alpha(colors.lavender, alpha),
    colors.change_alpha(colors.surface2, 0.8),
  }
  local day = os.date("%w")
  date:set({
    --icon = "", 
    icon = {
      string = "􀉉",
      y_offset = 1,
    },
    label = day .. os.date("%d%m%Y"),
    background = {
      border_color = days_color[tonumber(day) + 1],
    },
  })
end)
