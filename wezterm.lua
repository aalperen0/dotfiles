-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--color_scheme = 'Gruvbox (Gogh)',
--config.color_scheme = 'Gruvbox dark, hard (base16)'
config = {
  font = wezterm.font('FiraMono Nerd Font', {weight = "Bold"}),
  --enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  tab_and_split_indices_are_zero_based = true,
  use_fancy_tab_bar = false,
  color_scheme = 'Catppuccin Frappe',
  window_decorations = "RESIZE",
  window_background_opacity = 0.96,
  font_size = 13,
  
}

config.colors = {
  cursor_bg = "#e9a12f",
  cursor_border = "#e9a12f",
}


config.leader ={ key= 'q', mods = 'ALT'}
config.keys = {
  -- create tab and switch
   {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
   },
      {
        mods = "LEADER",
        key = "b",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1)
    },
  -- create a new split 
   {
     mods = "LEADER",
    key = '-',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
   },
   {
     mods = "LEADER",
    key = 'a',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  { 
    mods = "LEADER",
    key = 'L',
    action = act.QuickSelect
  },
  {
    key = 'w',
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = true },
  },
  -- SWITCH PANES

  {
    mods = 'LEADER',
    key = 'h',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    mods = 'LEADER',
    key = 'l',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    mods = 'LEADER',
    key = 'k',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    mods = 'LEADER',
    key = 'j',
    action = act.ActivatePaneDirection 'Down',
  },

  -- ADJUST PANE SIZE 
  {
    mods = "LEADER",
    key = 'LeftArrow',
    action = act.AdjustPaneSize { 'Left', 10 },
  },
  {
    mods = "LEADER",
    key = "DownArrow",
    action = act.AdjustPaneSize { 'Down', 10 },
  },
  { 
    mods = "LEADER",
    key = 'UpArrow',
    action = act.AdjustPaneSize { 'Up', 10 } },
  {
    mods = "LEADER",
    key = 'RightArrow',
    action = act.AdjustPaneSize { 'Right', 10 },
  },
}

-- activate tab -> leader + number 
for i = 0, 9 do
  table.insert(config.keys, {
      key = tostring(i),
      mods = "LEADER",
      action = wezterm.action.ActivateTab(i),
  })
end

wezterm.on("update-right-status", function(window, _)
    local SOLID_LEFT_ARROW = ""
    local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
    local prefix = ""

    if window:leader_is_active() then
        prefix = " " .. utf8.char(0x1F9A5) 
        SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    end

    if window:active_tab():tab_id() ~= 0 then
        ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
    end 

    window:set_left_status(wezterm.format {
        { Background = { Color = "#b7bdf8" } },
        { Text = prefix },
        ARROW_FOREGROUND,
        { Text = SOLID_LEFT_ARROW }
    })
end)


-- and finally, return the configuration to wezterm
return config
