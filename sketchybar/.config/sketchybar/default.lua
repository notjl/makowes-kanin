local colors = require("config.colors")

sbar.default({
  padding_left = 4,
  padding_right = 4,
  background = {
    color = colors.base,
    corner_radius = 10,
    height = 40,
  },
  icon = {
    color = colors.white,
    padding_left = 4,
    padding_right = 4,
    font = {
      family = "UbuntuMono Nerd Font",
      style = "Bold",
      size = 17.0,
    },
  },
  label = {
    color = colors.white,
    padding_left = 4,
    padding_right = 4,
    font = {
      family = "UbuntuMono Nerd Font",
      style = "Bold",
      size = 14.0,
    },
  }
})
