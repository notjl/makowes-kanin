local icons = require("config.icons")
local colors = require("config.colors")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 4.0")

local cpu = sbar.add("graph", "cpu" , 26, {
  position = "left",
  padding_right = 8,
  y_offset = -5,
  background = {
    height = 10,
    border_color = colors.transparent,
  },
  graph = {
    color = colors.sapphire,
    fill_color = colors.transparent,
  },
  icon = {
    string = icons.sf_symbol.cpu,
    y_offset = 6,
  },
  label = {
    string = "??%",
    align = "right",
    padding_right = 4,
    y_offset = 10,
    width = 0,
    font = {
      size = 11,
    }
  },
})

cpu:subscribe("cpu_update", function(env)
  local load = tonumber(env.total_load)
  cpu:push({ load / 100. })

  local color = colors.blue

  if load > 30 then
    if load < 60 then
      color = colors.yellow
    elseif load < 80 then
      color = colors.peach
    else
      color = colors.red
    end
  end

  cpu:set({
    graph = { color = color },
    label = env.total_load .. "%",
  })
end)

sbar.add("item", {
  position = "left",
  background = { drawing = false },
  width = 6,
})

sbar.add("bracket", { cpu.name }, {})
