vim.cmd [[ 
  set background=dark
  hi clear
  syntax reset

  let g:colors_name="neotwilight"
]]

-- Create a new syntax highlighting rule
local function hi(syntax, rules)
  vim.api.nvim_set_hl(0, syntax, rules)
end

local colors = {
  bg = "#1D1D1D",
  black = "#000000",
  blue = "#7587A6",
  brown = "#9B703F",
  gray = "#828282",
  green = "#8F9D6A",
  light_blue = "#AFC4DB",
  light_gray = "#666666",
  light_green = "#DAEFA3",
  light_orange = "#CDA869",
  light_red = "#E04331",
  light_yellow = "#F9EE98",
  red = "#F11818",
  salmon = "#CF6A4C",
  yellow = "#EEEE00",
  white = "#FFFFFF"
}

-- Syntax
hi("Boolean", { fg = colors.light_red, underline = true })
hi("Comment", { fg = colors.gray })
hi("Constant", { fg = colors.salmon })
hi("Define", { fg = colors.light_orange })
hi("Function", { fg = colors.brown })
hi("Identifier", { fg = colors.blue })
hi("Ignore", { fg = colors.light_gray })
hi("PreProc", { fg = colors.light_blue })
hi("Special", { fg = colors.light_green })
hi("Statement", { fg = colors.light_orange })
hi("String", { fg = colors.green })
hi("Todo", { fg = colors.yellow, bg = colors.black, underline = true })
hi("Type", { fg = colors.light_yellow })

-- Hide NonText characters by default.
-- There's function that will make them visible in .vimrc.
hi("NonText", { fg = colors.bg })

 -- UI Elements
hi("ColorColumn", { bg = "#130707" })
hi("Conceal", { fg = colors.white, bg = colors.bg })
hi("Cursor",  { fg = colors.bg, bg = "#F5773c" })
hi("CursorColumn", { bg = "#2D2D2D" })
hi("CursorLine", { bg = "#131313", bold = true })
hi("Directory", { fg = "#CFCFCF" })
hi("FoldColumn", { fg = "#444444", bg = "#080808" })
hi("Folded",  { bg = colors.bg, fg = "#434343", italic = true })
hi("LineNr", { bg = colors.bg, fg = "#434343" })
hi("MatchParen",  { fg= colors.red, bg = colors.bg })
hi("Normal", { bg = "#1D1D1D" })
hi("Pmenu",  { fg = "#F6F3E8", bg = "#242829" })
hi("PmenuSel", { fg = "#000000", bg = colors.light_green })
hi("SignColumn", { bg ="#1D1D1D" })
hi("TabLineSel", { fg = colors.light_green })
hi("VertSplit", { fg = "#181B22", bg = colors.bg })
hi("Visual",  { fg = "NONE", bg = "#1F4457", })
hi("WildMenu", { fg = colors.light_red, bg = colors.bg })

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua
hi("TSConstant", { fg = colors.light_red })
hi("TSKeywordReturn", { fg = colors.salmon, italic = true })


-- Warnings and Errors
hi("Error", { fg = colors.red, bg = "bg" })
hi("Warning", { fg = "#E7F6DA", bg = "#3A0505" })
hi("WarningMsg", { fg = colors.light_yellow, bg = colors.bg })

-- Status Line
hi("StatusLine", { fg = colors.light_gray, bg = colors.bg })
hi("StatusLineFile",  { bg = colors.bg })
hi("StatusLineFileType", { fg = "#8AC6F2", bg = colors.bg })
hi("StatusLineGit", { fg = "#D4EB9C", bg = colors.bg })
hi("StatusLineNC", { fg = "bg", bg = colors.bg })

-- Diff highlighting
hi("DiffAdd", { bg = "#012800" })
hi("DiffChange", { bg = "#472A00" })
hi("DiffDelete", { bg = "#290700", fg = "#290700" })
hi("DiffText",  { bg = colors.green, fg = "#080C06" })

-- Terminal colors
hi("Terminal", { bg = "#111720" })

-- Spelling
hi("SpellBad", { fg = "red", undercurl = true })

-- Floats
hi("FloatBorder", { fg = "#2A2A2A", bg = "#2A2A2A" })
hi("FloatTitle", { fg = "#CFCFCF", bg = "#2A2A2A" })
hi("NormalFloat", { bg = "#2A2A2A" })

-- Markdown
hi("markdownError", { fg = "None", bg = "None" })

-- Mini
hi("MiniIndentscopeSymbol", { fg = "#444444" })

-- Nvim Tree
hi("NvimTreeNormal", { bg = "#242222" })

-- Telescope
hi("TelescopeBorder", { fg = "#444444" })

-- Signify
hi("GitGutterAdd", { fg = "#7D8D57" })
hi("GitGutterAddLine", { bg ="#191919" })
hi("GitGutterChange", { fg = "#f5773C", bg = "NONE" })
hi("GitGutterChangeDelete",  { fg = "#f5773C", bg = "NONE" })
hi("GitGutterChangeDeleteLine", { bg = "#191919" })
hi("GitGutterChangeLine", { bg = "#191919" })
hi("GitGutterDelete", { fg = colors.red })
hi("GitGutterDeleteLine", { bg = "#191919" })

-- Yanky
hi("YankyPut", { bg = "#1A251A" })
hi("YankyYanked", { bg = "#1A251A" })
