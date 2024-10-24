local icons = require("config.icons")
local colors = require("config.colors")

local ram = require("items.ram")
local swap = require("items.swap")

local memory_bracket = sbar.add("bracket", "memory.bracket", {
  ram.name,
  swap.name,
}, {} )

ram:subscribe({"routine", "forced"}, function()
  sbar.exec("memory_pressure | grep -o 'System-wide memory free percentage: [0-9]*' | awk '{print $5}'",
  function(mem)
    local usedram = 100 - tonumber(mem)
    local label = usedram .. "%"

    local color = nil

    if usedram >= 80 then
      color = colors.change_alpha(colors.red, 0.8)
    elseif usedram >= 60 then
      color = colors.change_alpha(colors.maroon, 0.8)
    elseif usedram >= 30 then
      color = colors.change_alpha(colors.peach, 0.8)
    elseif usedram >= 20 then
      color = colors.change_alpha(colors.yellow, 0.8)
    else
      color = colors.change_alpha(colors.blue, 0.8)
    end

    ram:set({
      label = {
        string = label,
        -- color = color
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

