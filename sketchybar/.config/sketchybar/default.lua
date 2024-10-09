local colors = require("config.colors")

sbar.default({
  padding_left = 4,
  padding_right = 4,
  update_freq = 10,
  background = {
    border_width = 3,
    border_color = colors.change_alpha(colors.overlay0, 0.9),
    color = colors.change_alpha(colors.surface0, 0.9),
    corner_radius = 10,
    height = 28,
  },
  icon = {
    color = colors.white,
    padding_left = 9,
    padding_right = 4,
    font = {
      family = "UbuntuMono Nerd Font",
      style = "Bold",
      size = 14.0,
    },
  },
  label = {
    color = colors.white,
    padding_left = 4,
    padding_right = 9,
    font = {
      family = "UbuntuMono Nerd Font",
      style = "Bold",
      size = 15.0,
    },
  }
})
