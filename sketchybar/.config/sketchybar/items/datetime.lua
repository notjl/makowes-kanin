local clock = sbar.add("item", "clock",{
  position = "right",
  update_freq = 10,
  background = {
    color = 0x85585b70,
    height = 22,
  },
  icon = {
    padding_left = 9,
    font = {
      size = 12.0,
    },
  },
  label = {
    padding_right = 9,
    font = {
      size = 15.0,
    },
    align = "right",
  },
})

local date = sbar.add("item", "date", {
  position = "right",
  update_freq = 10,
  background = {
    color = 0x85585b70,
    height = 22,
  },
  icon = {
    padding_left = 9,
    font = {
      size = 12.0,
    },
  },
  label = {
    padding_right = 9,
    font = {
      size = 15.0,
    },
    align = "right",
  },
})

date:subscribe({"routine", "forced"}, function()
  local string = os.date("%w%d%m%Y")
  date:set({ icon = "", label = string })
end)

clock:subscribe({"routine", "forced"}, function()
  local string = os.date("%H%M")
  clock:set({ icon = "", label = string })
end)

-- sbar.add("bracket", {"clock", "date"}, {
  -- background = {
    -- color = 0x20EEEEEE,
    --height = 30
  -- },
-- })
