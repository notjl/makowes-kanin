local icons = require("config.icons")
local colors = require("config.colors")

local gap = sbar.add("item", {
  position = "left",
  background = { drawing = false },
})

local ssd = sbar.add("item", "ssd", {
  position = "left",
  icon = { string = "󰪥" },
  label = { string = "test"},
})

local function get_used_storage()
  local raw_result = io.popen("df -H /System/Volumes/Data")
  local last_line = nil

  for line in raw_result:lines() do
    last_line = line
  end

  raw_result:close()

  return tonumber(last_line:match("(%d+)%%"))
end

ssd:subscribe({"routine", "forced"}, function()
  local used_storage = get_used_storage()
  local icon = nil
  local border_color = nil

  for _, threshold in ipairs({95, 87, 75, 62, 50, 37, 25, 12, 0}) do
      if used_storage >= threshold then
          icon = icons.nerd_font.storage["_" .. threshold]
          break
      end
  end

  if used_storage >= 75 then
    border_color = colors.change_alpha(colors.red, 0.8)
  elseif used_storage >= 50 then
    border_color = colors.change_alpha(colors.peach, 0.8)
  elseif used_storage >= 25 then
    border_color = colors.change_alpha(colors.yellow, 0.8)
  elseif used_storage >= 0 then
    border_color = colors.change_alpha(colors.blue, 0.6)
  end

  ssd:set({
    icon = { string = icon },
    label = { string = used_storage .. "%" },
    background = { border_color = border_color },
  })
end)

return gap
