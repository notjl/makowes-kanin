local colors = require("config.colors")

local clock = sbar.add("item", "clock", {
  position = "right",
})

clock:subscribe({"routine", "forced"}, function()
  local color = nil
  local hour = os.date("%H")

  if hour > "06" and hour < "18" then
    color = colors.change_alpha(colors.yellow, 0.60)
  else
     color = colors.change_alpha(colors.overlay0, 0.9)
  end

  local string = hour .. os.date("%M")
  clock:set({
    icon = "􀐫",
    label = string,
    background = {
      border_color = color,
    }
  })
end)

-- sbar.add("bracket", {"clock", "date"}, {
  -- background = {
    -- color = 0x20EEEEEE,
    --height = 30
  -- },
-- })
