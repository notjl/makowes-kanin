return {
  -- SF Symbols need to have an y_offset of 1 since they aren't centered vertic-
  -- ally.
  spaces = { "㆒", "二", "三", "四", "五", "六", "七", "八", "九", "十" },

  sf_symbol = {
    clock = "􀐫 ",
    calendar = "􀉉 ",
    cpu = "􀫥 ",
    memory = {
      ram = "􀫦 ",
      swap = "􀅋 ",
    },
    wifi = {
      upload = "􀓂 ",
      download = "􀓃 ",
      connected = "􀙇 ",
      disconnected  = "􀙈 ",
      router = "􁓣 ",
    },
    battery = {
      _100 = "􀛨 ",
      _75 = "􀺸 ",
      _50 = "􀺶 ",
      _25 = "􀛩 ",
      _0 = "􀛪 ",
      charging = "􀢋 ",
    },
  },

  nerd_font = {
    clock = "󱑓",
    calendar = "",
    logo = { "", "󰹻", "", "󰀚", "" },
    memory = {
      ram = "",
      swap = "󰍛",
    },
    wifi = {
      upload = "󰚷",
      download = "󰚶",
      connected = "󰖩",
      disconnected  = "󰖪",
      router = "󰑩",
    },
    storage = {
      _0 = "󰄰",
      _12 = "󰪞",
      _25 = "󰪟",
      _37 = "󰪠",
      _50 = "󰪡",
      _62 = "󰪢",
      _75 = "󰪣",
      _87 = "󰪤",
      _95 = "󰪥",
    },
    battery = {
      _100 = "󰁹",
      _90 = "󰂂",
      _80 = "󰂁",
      _70 = "󰂀",
      _60 = "󰁿",
      _50 = "󰁾",
      _40 = "󰁽",
      _30 = "󰁼",
      _20 = "󰁻",
      _10 = "󰁺",
      _0 = "󰂎",
      charging = {
      _100 = "󰂅",
      _90 = "󰂋",
      _80 = "󰂊",
      _70 = "󰢞",
      _60 = "󰂉",
      _50 = "󰢝",
      _40 = "󰂈",
      _30 = "󰂇",
      _20 = "󰂆",
      _10 = "󰢜",
      _0 = "󰢟",
      },
    },
  }

}
