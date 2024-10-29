local colors = require("config.colors")
local icons = require("config.icons")

local LIST_CURRENT = "aerospace list-workspaces --focused"
local spaces = {}

local workspaces = {3, 2, 1, 4, 5, 6}

local function add_workspace_item(workspace_name)
  local space = "workspace." .. workspace_name
  local item_pos = (workspace_name <= 3) and "q" or "e"

  spaces[space] = sbar.add("item", space, {
    position = item_pos,
    icon = { string = icons.spaces[tonumber(workspace_name)] },
    update_freq = 1,
    click_script = "aerospace workspace " .. workspace_name
  })

  spaces[space]:subscribe("aerospace_workspace_change", function(env)
    for sid, space_item in pairs(spaces) do
      if space_item ~= nil then
        local is_selected = sid == "workspace." .. env.FOCUSED
        space_item:set({
          background = { border_color = is_selected and colors.blue or colors.text },
        })
      end
    end
  end)

end

for _, workspace in pairs(workspaces) do
  add_workspace_item(workspace)
end

spaces["workspace.3"]:set({
  padding_right = 8,
})
spaces["workspace.4"]:set({
  padding_left = 10,
})

sbar.exec(LIST_CURRENT, function(focused_workspace)
  local focused_workspace_name = focused_workspace:match("[^\r\n]+")
  for sid, space in pairs(spaces) do
    local is_selected = sid == "workspace." .. focused_workspace_name
    space:set({
      background = { border_color = is_selected and colors.blue or colors.text },
    })
  end
end)
