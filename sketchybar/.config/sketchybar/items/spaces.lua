local colors = require("config.colors")
local icons = require("config.icons")

local LIST_CURRENT = "aerospace list-workspaces --focused"
local spaces = {}

local workspaces = {3, 2, 1, 4, 5, 6}
local space_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

local function select_focused_space(env)
  local blue = colors.change_alpha(colors.blue, 0.8)
  local white = colors.change_alpha(colors.text, 0.8)

  for space_id, item in pairs(spaces) do
    if item ~= nil then
      local is_selected = space_id == "workspace." .. env.FOCUSED
      sbar.animate("tanh", 25, function()
        item:set({
          background = {
            border_color = is_selected and blue or white,
            height = is_selected and 35 or 30,
          },
        })
      end)
    end
  end
end

local function find_select_focused_space()
  sbar.exec(LIST_CURRENT, function(focused_space)
    local env = { FOCUSED = focused_space:match("[^\r\n]+") }
    select_focused_space(env)
  end)
end

local function add_workspace_item(workspace_name)
  local space_id = "workspace." .. workspace_name
  local item_pos = (workspace_name <= 3) and "q" or "e"
  local notch_padding = {
    [3] = { padding_right = 8 },
    [4] = { padding_left = 10 }
  }

  if not spaces[space_id] then
    spaces[space_id] = sbar.add("item", space_id, {
      position = item_pos,
      click_script = "aerospace workspace " .. workspace_name,
      background = { height = 30 },
      icon = {
        string = icons.spaces[workspace_name],
        padding_left = 18,
      },
    })
  end

  local padding = notch_padding[workspace_name]
  if padding then
    spaces[space_id]:set(padding)
  end
end

local function create_workspace()
  for _, workspace_name in pairs(workspaces) do
    add_workspace_item(workspace_name)
  end
  find_select_focused_space()
end

create_workspace()

space_observer:subscribe("aerospace_workspace_change", function(env)
  select_focused_space(env)
end)

