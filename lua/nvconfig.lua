local M = {}

M.ui = {
  ------------------------------- base46 -------------------------------------
  -- hl = highlights
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { 'onenord' },
  theme = 'onenord', -- default theme
  transparency = false,

  cmp = {
    icons = true,
    lspkind_text = true,
    style = 'atom_colored', -- default/flat_light/flat_dark/atom/atom_colored
  },

  telescope = { style = 'borderless' }, -- borderless / bordered

  ------------------------------- nvchad_ui modules -----------------------------
  statusline = {
    theme = 'default', -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = 'arrow',
    order = nil,
    modules = nil,
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { 'buffers', 'tabs', 'btns' },
    modules = nil,
  },

  nvdash = {
    load_on_startup = true,

    header = {
      '___________                            .__         ',
      '\\__    ___/____ ______       _______  _|__| _____  ',
      '  |    | /     \\\\____ \\     /    \\  \\/ /  |/     \\ ',
      '  |    ||  Y Y  \\  |_> >   |   |  \\   /|  |  Y Y  \\',
      '  |____||__|_|  /   __/ /\\ |___|  /\\_/ |__|__|_|  /',
      '              \\/|__|    \\/      \\/              \\/ ',
    },

    buttons = {
      { '  Find File', 'Spc s f', 'Telescope find_files' },
      { '󰈭  Find Word', 'Spc f w', 'Telescope live_grep' },
      { '  Bookmarks', 'Spc m a', 'Telescope marks' },
      { '  Themes', 'Spc t h', 'Telescope themes' },
    },
  },

  term = {
    hl = 'Normal:term,WinSeparator:WinSeparator',
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = 'editor',
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = 'single',
    },
  },
}

M.base46 = {
  integrations = {
    'rainbowdelimiters',
    'neogit',
    'dap',
  },
}

M.cheatsheet = {
    theme = 'grid', -- simple/grid
    excluded_groups = { 'terminal (t)', 'autopairs', 'Nvim', 'Opens' }, -- can add group name or with mode
}

M.lsp = {
  signature = true 
}


return M
