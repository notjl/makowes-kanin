local icons = require("config.icons")
local colors = require("config.colors")

sbar.add("item", {
  position = "left",
})

local ram = sbar.add("item", "memory.ram", {
  position = "left",
  width = 0,
  y_offset = 6,
  update_freq = 4,
  icon = {
    string = icons.nerd_font.memory.ram,
    padding_left = 12,
    font = { size = 10.0 },
  },
  label = {
    string = "???%",
    color = colors.subtext0,
    font = { size = 13.0 },
  },
})

local swap = sbar.add("item", "memory.swap", {
  position = "left",
  background = { drawing = false },
  y_offset = -3,
  update_freq = 4,
  icon = {
    string = icons.nerd_font.memory.swap,
    padding_left = 14,
    font = { size = 10.0},
  },
  label = {
    string = "??.?Mb",
    padding_right = 12,
    font = { size = 13.0 },
  },
})


sbar.add("bracket", {
  ram.name,
  swap.name,
}, {})

ram:subscribe({"routine", "forced"}, function()
  sbar.exec("memory_pressure | grep -o 'System-wide memory free percentage: [0-9]*' | awk '{print $5}'",
  function(mem)
    local usedram = 100 - tonumber(mem)
    local label = usedram .. "%"

    local color = nil

    if usedram >= 80 then
      color = colors.red
    elseif usedram >= 60 then
      color = colors.maroon
    elseif usedram >= 30 then
      color = colors.peach
    elseif usedram >= 20 then
      color = colors.yellow
    else
      color = colors.blue
    end

    ram:set({
      label = {
        string = label,
        color = color
      },
    })
  end)
end)

local function format_swap_usage(swapuse)
  if swapuse == 0 then
    return "0.00Mb", colors.subtext0
  elseif swapuse >= 1536 then
    return string.format("%.2fGb", swapuse / 1000), colors.red
  elseif swapuse >= 1000 then
    return string.format("%.2fGb", swapuse / 1000), colors.maroon
  elseif swapuse >= 512 then
    return string.format("%03dMb", math.floor(swapuse)), colors.peach
  elseif swapuse >= 256 then
    return string.format("%03dMb", math.floor(swapuse)), colors.yellow
  elseif swapuse >= 128 then
    return string.format("%03dMb", math.floor(swapuse)), colors.blue
  end
end

swap:subscribe({"routine", "forced"}, function()
  sbar.exec("sysctl -n vm.swapusage | awk '{print $6}' | sed 's/M//'",
  function(swapstore_untrimmed)
    if swapstore_untrimmed then
      local swapstore = swapstore_untrimmed:gsub("%s*$", "")

      swapstore = swapstore:gsub(",", ".")
      local swapuse = tonumber(swapstore)

      local swap_label, swap_color = format_swap_usage(swapuse)
      swap:set({
        label = {
          string = swap_label,
          color = swap_color,
        },
      })
    end
  end)
end)
