vim.cmd [[ 
  set background=dark
  hi clear
  syntax reset

  let g:colors_name="neotwilight"
]]

-- Create a new syntax highlighting rule
local function hi(syntax, rules)
  local highlightCmd = "hi " .. syntax .. " "
  for key, value in pairs(rules) do
    highlightCmd = highlightCmd .. key .. '=' .. value .. " "
  end

  vim.cmd(highlightCmd)
end

local colors = {
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
hi("Boolean", { guifg = colors.light_red, gui = "underline" })
hi("Comment", { guifg = colors.gray })
hi("Constant", { guifg = colors.salmon })
hi("Define", { guifg = colors.light_orange, gui = "none" })
hi("Function", { guifg = colors.brown })
hi("Identifier", { guifg = colors.blue, gui = "none" })
hi("Ignore", { guifg = colors.light_gray })
hi("PreProc", { guifg = colors.light_blue })
hi("Special", { guifg = colors.light_green })
hi("Statement", { guifg = colors.light_orange })
hi("String", { guifg = colors.green })
hi("Todo", { guifg = colors.yellow, guibg = colors.black, gui = "underline" })
hi("Type", { guifg = colors.light_yellow })

-- Hide NonText characters by default.
-- There's function that will make them visible in .vimrc.
hi("NonText", { guifg = "bg" })

 -- UI Elements
hi("ColorColumn", { guibg = "#130707" })
hi("Conceal", { guifg = colors.white, guibg = "bg" })
hi("Cursor",  { guifg = "bg", guibg = "#F5773c",  gui = "NONE" })
hi("CursorColumn", { guibg = "#2D2D2D" })
hi("CursorLine", { guibg = "#131313", gui = "bold" })
hi("Directory", { guifg = "#CFCFCF" })
hi("FoldColumn", { guifg = "#444444", guibg = "#080808" })
hi("Folded",  { guibg = "bg", guifg = "#434343", gui = "italic" })
hi("LineNr", { guibg = "bg", guifg = "#434343" })
hi("MatchParen",  { guifg= colors.red, guibg = "bg" })
hi("Normal", { guibg = "#1D1D1D", gui = "NONE" })
hi("Pmenu",  { guifg = "#F6F3E8", guibg = "#242829" })
hi("PmenuSel", { guifg = "#000000", guibg = colors.light_green })
hi("SignColumn", { guibg="#1D1D1D" })
hi("TabLineSel", { guifg = colors.light_green })
hi("VertSplit", { guifg = "#181B22", guibg="bg", gui = "NONE" })
hi("Visual",  { guifg = "NONE", guibg = "#1F4457", gui = "none" })
hi("WildMenu", { guifg = colors.light_red, guibg = "bg" })

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua
hi("TSConstant", { guifg = colors.light_red, gui = "bold" })
hi("TSKeywordReturn", { gui = "italic" })

-- Warnings and Errors
hi("Error", { guifg = colors.red, guibg = "bg" })
hi("Warning", { guifg = "#E7F6DA", guibg = "#3A0505" })
hi("WarningMsg", { guifg = colors.light_yellow, guibg = "bg" })

-- Status Line
hi("StatusLine", { guifg = colors.light_gray, guibg = "bg", gui = "NONE" })
hi("StatusLineFile",  { guibg = "bg" })
hi("StatusLineFileType", { guifg = "#8AC6F2", guibg = "bg" })
hi("StatusLineGit", { guifg = "#D4EB9C", guibg = "bg" })
hi("StatusLineNC", { guifg = "bg", guibg = "bg" })

-- Diff highlighting
hi("DiffAdd", { guibg = colors.light_green, guifg = "#080C06" })
hi("DiffChange", { guibg = colors.light_orange, guifg = colors.black })
hi("DiffDelete", { guibg = "#290700", guifg = "#290700" })
hi("DiffText",  { guibg = colors.green, guifg = "#080C06" })

-- Terminal colors
hi("Terminal", { guibg = "#111720", guifg = "fg" })

-- Spelling
hi("SpellBad", { guifg = "red", gui = "undercurl" })

-- Floats
hi("FloatBorder", { guifg = "#444444" })
hi("FloatTitle", { guifg = "#CFCFCF", guibg = "bg" })

-- Mini
hi("MiniIndentscopeSymbol", { guifg = "#444444" })

-- Telescope
hi("TelescopeBorder", { guifg = "#444444" })

-- Signify plugin
hi("GitGutterAdd", { guifg = "#7D8D57" })
hi("GitGutterAddLine", { guibg="#191919" })
hi("GitGutterChange", { guifg = "#f5773C", guibg = "NONE" })
hi("GitGutterChangeDelete",  { guifg = "#f5773C", guibg = "NONE" })
hi("GitGutterChangeDeleteLine", { guibg = "#191919" })
hi("GitGutterChangeLine", { guibg = "#191919" })
hi("GitGutterDelete", { guifg = colors.red })
hi("GitGutterDeleteLine", { guibg = "#191919" })
