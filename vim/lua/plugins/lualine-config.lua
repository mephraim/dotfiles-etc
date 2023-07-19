local lualine = require('lualine')

-- Color table for highlights
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#F9ED9D',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#8F9C6C',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#81a2be',
  red      = '#ec5f67',
}

-- auto change color according to neovim mode
local mode_color = {
  n = colors.blue,
  i = colors.green,
  v = colors.red,
  [''] = colors.blue,
  V = colors.red,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.red,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,

  buffer_is_modified = function()
    return vim.fn.getbufinfo('%')[1].changed > 0
  end,

  show_if_not_filetype = function()
    local filetypes = {
      'ctrlsf',
      'DiffviewFiles',
      'fugitiveblame',
      'NvimTree',
      'packer',
      'TelescopePrompt',
      'Trouble'
    }

    for _, value in ipairs(filetypes) do
      if value == vim.o.filetype then
        return false
      end
    end

    return true
  end,

  show_if_wide_enough = function()
    -- Get the total number of columns for the whole terminal
    return vim.o.columns > 80
  end,
}

local diff_component = {
  'diff',

  color = {
    bg = colors.bg
  },

  symbols = { added = ' ', modified = ' ', removed = ' ' },

  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },

  cond = function ()
    return conditions.show_if_not_filetype() and
      conditions.show_if_wide_enough()
  end
}

local file_icon_component = {
  function ()
    return ""
  end,

  color = function ()
    if conditions.buffer_is_modified() then
      return { fg = colors.orange, bg = colors.bg }
    else
      return { fg = colors.fg, bg = colors.bg }
    end
  end,

  padding = { right = 0, left = 1 },

  cond = function()
    return conditions.buffer_not_empty() and
      conditions.show_if_not_filetype()
  end,
}

local filename_component = {
  "filename",
  color = { fg = colors.fg, bg = colors.bg },
  file_status = false,
  path = 1,
  cond = function()
    return conditions.buffer_not_empty() and
      conditions.show_if_not_filetype()
  end
}

local filetype_component = {
  'filetype',
  colored = true,
  icon_only = false,
  color = {
    bg = colors.bg,
    fg = colors.fg
  },
  padding = {
    left = 1,
    right = 1
  },
  cond = conditions.show_if_not_filetype
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',

    global_status = true
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },

  winbar = {
    lualine_a = {
      file_icon_component,
      filename_component,
      filetype_component,
      diff_component
    },
    lualine_z = {}
  },

  inactive_winbar = {
    lualine_a = {
      file_icon_component,
      filename_component,
      filetype_component,
      diff_component
    },
    lualine_y = {},
    lualine_z = {}
  }
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

local function is_recording()
  return vim.fn.reg_recording() ~= ''
end

ins_left {
  function()
    return '▊'
  end,

  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,

  padding = { left = 0, right = 1 }
}

ins_left {
  -- mode component
  function()
    if vim.o.filetype == 'ctrlsf' then
      return ''
    end

    if vim.o.filetype == 'fugitiveblame' then
      return ''
    end

    if vim.o.filetype == 'NvimTree' then
      return ''
    end

    if vim.o.filetype == 'TelescopePrompt' then
      return ''
    end

    if vim.o.filetype == 'Trouble' then
      return ''
    end

    if vim.fn.mode() =='c' then
     return ''
   end

    if vim.fn.mode() == 'i' then
      return '󰙏'
    end

    if vim.fn.mode() =='v' or string.find(vim.fn.mode(), 'V') then
      return ''
    end

    return ''
  end,

  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,

  padding = { right = 1 },
}

-- Git branch component
ins_left {
  'branch',
  icon = '',
  color = { fg = colors.blue, gui = 'bold' },
}

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Macro recording indicator
ins_left {
  function()
    if is_recording() then
      return '⊚ recording'
    end
  end,

  color = {
    fg = colors.red
  },

  cond = is_recording,
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

-- LSP
ins_right {
  function()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return 'none'
    end

    local current_buffer_lsps = {}
    local current_buffer_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    for _, client in ipairs(clients) do
      local lsp_client_filetypes = client.config.filetypes
      if lsp_client_filetypes and vim.fn.index(lsp_client_filetypes, current_buffer_ft) ~= -1 then
        current_buffer_lsps[#current_buffer_lsps + 1] = client.name
      end
    end

    if next(current_buffer_lsps) == nil then
      return 'none'
    else
      return table.concat(current_buffer_lsps, '˖')
    end
  end,

  icon = {
    '',
    color = {
      fg = colors.cyan
    }
  },
  color = { fg = colors.fg },
  cond = conditions.buffer_not_empty
}

ins_right {
  'fileformat',
  fmt = string.upper,
  color = { fg = colors.blue, gui = 'bold' },
}

-- filesize component
ins_right {
  'filesize',
  cond = conditions.buffer_not_empty,
}

-- Location in the file
ins_right {
  'location'
}

-- Progress in the file
ins_right {
  'progress'
}

ins_right {
  function()
    return '▊'
  end,

  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,

  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
