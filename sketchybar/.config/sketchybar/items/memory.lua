local icons = require("config.icons")
local colors = require("config.colors")

local ram = require("items.ram")
local swap = require("items.swap")
local gap = require("items.storage")

local memory_bracket = sbar.add("bracket", "memory.bracket", {
  ram.name,
  swap.name,
}, {} )

local function get_used_ram()
  local raw_result = io.popen("memory_pressure")
  local output = raw_result:read("*a")
  raw_result:close()

  local free_ram = output:match("System%-wide memory free percentage: (%d+)")
  return 100 - tonumber(free_ram)
end

ram:subscribe({"routine", "forced"}, function()
  sbar.exec("memory_pressure", function(ram_info)
    local found, _, free_ram = ram_info:find("System%-wide memory free percentage: (%d+)")
    local used_ram = 100 - tonumber(free_ram)
    local label = used_ram .. "%"

    local color = nil

    if used_ram >= 80 then
      color = colors.change_alpha(colors.red, 0.8)
    elseif used_ram >= 60 then
      color = colors.change_alpha(colors.maroon, 0.8)
    elseif used_ram >= 30 then
      color = colors.change_alpha(colors.peach, 0.8)
    elseif used_ram >= 20 then
      color = colors.change_alpha(colors.yellow, 0.8)
    else
      color = colors.change_alpha(colors.blue, 0.8)
    end

    ram:set({
      label = {
        string = label,
      },
    })
    memory_bracket:set({ background = { border_color = color } })
  end)
end)

local function show_swap()
  sbar.animate("tanh", 30, function()
    swap:set({
      icon = { font = { size = 10.0 } },
      label = { font = { size = 13.0 } }
    })
    gap:set({ width = 4 })
  end)
  sbar.animate("tanh", 10, function()
    ram:set({
      y_offset = 6,
      icon = { font = { size = 10.0 } },
      label = { font = { size = 13.0 } },
    })
    memory_bracket:set({ background = { height = 35 } })
  end)
end

local function hide_swap()
  sbar.animate("tanh", 10, function()
    swap:set({
      icon = { font = { size = 0.5 } },
      label = { font = { size = 0.5 } }
    })
    gap:set({ width = "dynamic" })
  end)
  sbar.animate("tanh", 30, function()
    ram:set({
      y_offset = 0,
      icon = { font = { size = 15.0 } },
      label = { font = { size = 15.0 } },
    })
    memory_bracket:set({ background = { height = 28 } })
  end)
end

local function toggle_swap()
  local should_draw = ram:query().geometry.y_offset == 0
  if should_draw then
    show_swap()
  else
    hide_swap()
  end
end

ram:subscribe("mouse.clicked", toggle_swap)
swap:subscribe("mouse.clicked", toggle_swap)
