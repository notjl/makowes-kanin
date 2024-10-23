local icons = require("config.icons")
local colors = require("config.colors")

sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 4.0")

sbar.add("item", {
  position = "right",
  width = 8,
  background = { drawing = false },
})

local cpu = sbar.add("graph", "cpu" , 26, {
  position = "right",
  padding_right = 8,
  width = 0,
  y_offset = -5,
  background = {
    height = 10,
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

sbar.add("bracket", { cpu.name }, {})
