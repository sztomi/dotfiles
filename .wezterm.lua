local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- ==========================================
-- 1. BASE SETTINGS & AESTHETICS
-- ==========================================
config.font = wezterm.font('Berkeley Mono')
config.font_size = 13.5

-- From tmux: set-option -g history-limit 250000
config.scrollback_lines = 250000

config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.window_padding = {
  left = 8,
  right = 2,
  top = 8,
  bottom = 2,
}

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- Start maximized (covers screen, keeps titlebar; not macOS native fullscreen).
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- Fancy bar styling: match tab colors/font of the old retro look.
config.window_frame = {
  font = wezterm.font('Berkeley Mono'),
  font_size = 13.5,
  active_titlebar_bg = '#3e4451',
  inactive_titlebar_bg = '#3e4451',
}

-- ==========================================
-- 2. COLOR SCHEME (iTerm2 sRGB Export)
-- ==========================================
local colors = {
  foreground = '#3d2b5a', 
  background = '#f6f2ee', 
  cursor_bg = '#3d2b5a', 
  cursor_border = '#3d2b5a', 
  cursor_fg = '#f6f2ee', 
  selection_bg = '#e7d2be', 
  selection_fg = '#3d2b5a', 
  ansi = { '#352c24', '#a5222f', '#396847', '#ac5402', '#2848a9', '#6e33ce', '#287980', '#f2e9e1' },
  brights = { '#534c45', '#b3434e', '#577f63', '#b86e28', '#4863b6', '#8452d5', '#488d93', '#f4ebe6' },
}

config.colors = colors

-- Styling the tab bar to match the 'snow' theme on a light background
config.colors.tab_bar = {
  background = '#3e4451',
  
  active_tab = {
    -- The desaturated blue/purple
    bg_color = '#667496',
    fg_color = '#ffffff',
    intensity = 'Bold',
  },
  
  inactive_tab = {
    -- Matches the bar background
    bg_color = '#3e4451',
    fg_color = '#d3d3d3',
  },
  
  inactive_tab_hover = {
    -- Slightly lighter gray for hover state
    bg_color = '#4b5263',
    fg_color = '#ffffff',
  },
}

-- ==========================================
-- 3. SSH MUX SERVER CONFIGURATION
-- ==========================================

config.ssh_domains = {
  {
    name = 'mamut',
    remote_address = 'mamut',
    username = 'tamas',
    multiplexing = 'WezTerm',
    
    -- Point to the newly downloaded binary
    remote_wezterm_path = '/home/tamas/.local/bin/wezterm',
  },
}

-- ==========================================
-- 4. TMUX KEYBINDINGS
-- ==========================================
-- Default tmux prefix (Ctrl+b)
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }

config.keys = {
  -- Reload Config (prefix + r)
  { key = 'r', mods = 'LEADER', action = act.ReloadConfiguration },

  -- SPLITS
  -- Prefix + - (Vertical split)
  { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  -- Prefix + | (Horizontal split)
  { key = '|', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- ZOOM
  -- Prefix + z (Toggle zoom)
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

  -- TABS (Windows)
  -- New tab in the active pane's domain: remote host if on a remote tab, else local.
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(
        act.SpawnTab { DomainName = pane:get_domain_name() },
        pane)
    end),
  },
  -- Rename tab (tmux prefix + ,)
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Rename tab',
      action = wezterm.action_callback(function(window, _, line)
        -- line is nil if user pressed Escape; empty string clears the override
        if line ~= nil then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = 'p', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'n', mods = 'LEADER', action = act.ActivateTabRelative(1) },

  -- VIM-STYLE PANE NAVIGATION
  -- Prefix + h, j, k, l
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

  -- MOVE AND ZOOM (Your custom Ctrl+k / Ctrl+j workflow)
  -- Prefix + Ctrl+k: Move Up AND Zoom
  {
    key = 'k',
    mods = 'LEADER|CTRL',
    action = act.Multiple {
      act.ActivatePaneDirection 'Up',
      act.TogglePaneZoomState,
    },
  },
  -- Prefix + Ctrl+j: Move Down AND Zoom
  {
    key = 'j',
    mods = 'LEADER|CTRL',
    action = act.Multiple {
      act.ActivatePaneDirection 'Down',
      act.TogglePaneZoomState,
    },
  },
}

-- TABS BY NUMBER (tmux prefix + <n>)
-- Visible tab number is 1-based; ActivateTab is 0-based.
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

-- ==========================================
-- 5. DYNAMIC TAB ICONS & FORMATTING
-- ==========================================
wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  -- Concatenate title and process to ensure we catch the name regardless of shell interference
  local search_str = ((pane.title or "") .. " " .. (pane.foreground_process_name or "")):lower()
  
  -- 1. Defaults
  local icon = wezterm.nerdfonts.fa_terminal
  local name = pane.foreground_process_name and pane.foreground_process_name:match("([^/\\]+)$") or "shell"

  -- 2. Rules
  if search_str:find("nvim") or search_str:find("vim") then
    icon = wezterm.nerdfonts.custom_vim
    name = "nvim"
  elseif search_str:find("claude") then
    -- md_robot (Material Design robot); cod_robot does not exist in wezterm's nerdfonts table
    icon = wezterm.nerdfonts.md_robot
    name = "claude"
  elseif search_str:find("zsh") then
    icon = wezterm.nerdfonts.dev_terminal
    name = "zsh"
  end

  -- Manual rename (LEADER+,) wins over the computed name.
  if tab.tab_title and #tab.tab_title > 0 then
    name = tab.tab_title
  end

  local title = string.format("  %d: %s %s  ", tab.tab_index + 1, icon, name)

  -- 3. Remote tabs get a distinct highlight color.
  -- Local panes report domain_name "local"; SSH mux domains report their name (e.g. "mamut").
  local is_remote = pane.domain_name and pane.domain_name ~= "local"
  if is_remote then
    local bg = tab.is_active and '#c08866' or '#8f6650' -- amber/rust = remote
    return {
      { Background = { Color = bg } },
      { Foreground = { Color = '#ffffff' } },
      { Text = title },
    }
  end

  return title
end)

return config
