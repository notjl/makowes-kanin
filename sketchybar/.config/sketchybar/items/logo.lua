local icons = require("config.icons")
local colors = require("config.colors")

local logos = icons.nerd_font.logo

local logo = sbar.add("item", "logo", {
  position = "left",
  update_freq = 3600,
  padding_right = 6,
  icon = {
    string = "󰹻",
    padding_left = 12,
    padding_right = 11,
    font = {
      size = 15
    },
  },
  label = { drawing = false },
})

logo:subscribe("routine", function()
  local icon_index = math.random(#logos)

  sbar.animate("tanh", 15, function()
    logo:set({
      icon = { font = { size = 0.5 } },
      background = { height = 1 },
    })
  end)

  sbar.delay(.2, function()
    sbar.animate("tanh", 25, function()
      logo:set({
        icon = { 
          string = logos[icon_index],
          font = { size = 20 },
        },
        background = { height = 35 },
      })
    end)
  end)

  sbar.delay(.60, function()
    sbar.animate("tanh", 10, function()
      logo:set({
        icon = { 
          string = logos[icon_index],
          font = { size = 15 },
        },
        background = { height = 28 },
      })
    end)
  end)

end)
