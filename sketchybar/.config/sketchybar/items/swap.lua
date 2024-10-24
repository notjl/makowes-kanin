local icons = require("config.icons")
local colors = require("config.colors")

local swap = sbar.add("item", "memory.swap", {
  position = "left",
  background = { drawing = false },
  y_offset = -3,
  update_freq = 4,
  icon = {
    string = icons.nerd_font.memory.swap,
    padding_left = 14,
    font = { size = 0.5},
  },
  label = {
    string = "??.?Mb",
    padding_right = 12,
    font = { size = 0.5 },
  },
})

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

return swap
