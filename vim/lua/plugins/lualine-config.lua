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

  show_if_not_filetype = function()
    local filetypes = {
      'ctrlsf',
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

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
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
}

local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
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
      return ''
    end

    if vim.o.filetype == 'fugitiveblame' then
      return ''
    end

    if vim.o.filetype == 'NvimTree' then
      return ''
    end

    if vim.o.filetype == 'TelescopePrompt' then
      return ''
    end

    if vim.o.filetype == 'Trouble' then
      return ''
    end

    if vim.fn.mode() =='c' then
     return ''
   end

    if vim.fn.mode() == 'i' then
      return ''
    end

    if vim.fn.mode() =='v' or string.find(vim.fn.mode(), 'V') then
      return '﯎'
    end

    return ''
  end,

  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,

  padding = { right = 1 },
}

-- filename component
ins_left {
  'filename',
  path = 1,
  cond = function()
    return conditions.buffer_not_empty() and
      conditions.show_if_not_filetype()
  end,
  color = { fg = colors.green },
  shorting_target = 20
}

-- Git branch component
ins_left {
  'branch',
  icon = '',
  color = { fg = colors.blue, gui = 'bold' },
}

-- Git diff component
ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.show_if_wide_enough,
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

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

-- LSP server
ins_right {
  function()
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return 'none'
    end

    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end

    return 'none'
  end,

  icon = '',
  color = { fg = colors.fg },
  cond = conditions.buffer_not_empty
}

ins_right {
  'filetype',
  color = function()
    local _, color = require('nvim-web-devicons').get_icon_color(vim.fn.expand('%:t'), vim.o.filetype)
    return {
      fg = color
    }
  end,
  gui = 'bold',
  cond = conditions.show_if_not_filetype
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
