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

-- Syntax
hi("Boolean", { guifg = "#E04331", gui = "underline" })
hi("Comment", { guifg = "#828282" })
hi("Constant", { guifg = "#CF6A4C" })
hi("Define", { guifg = "#CDA869", gui = "none" })
hi("Function", { guifg = "#9B703F" })
hi("Identifier", { guifg = "#7587A6", gui = "none" })
hi("Ignore", { guifg = "#666666" })
hi("PreProc", { guifg = "#AFC4DB" })
hi("Special", { guifg = "#DAEFA3" })
hi("Statement", { guifg = "#CDA869" })
hi("String", { guifg = "#8F9D6A" })
hi("Todo", { guifg = "#EEEE00", guibg = "#000000", gui = "underline" })
hi("Type", { guifg = "#F9EE98" })

-- Hide NonText characters by default.
-- There's function that will make them visible in .vimrc.
hi("NonText", { guifg = "bg" })

 -- UI Elements
hi("ColorColumn", { guibg = "#130707" })
hi("Conceal", { guifg = '#FFFFFF', guibg = "bg" })
hi("Cursor",  { guifg = "bg", guibg = "#F5773c",  gui = "NONE" })
hi("CursorColumn", { guibg = "#2D2D2D" })
hi("CursorLine", { guibg = "#131313", gui = "bold" })
hi("Directory", { guifg = "#CFCFCF" })
hi("FoldColumn", { guifg = "#444444", guibg = "#080808" })
hi("Folded",  { guibg = "bg", guifg = "#434343", gui = "italic" })
hi("LineNr", { guibg = "bg", guifg = "#434343" })
hi("MatchParen",  { guifg= "#E04331", guibg = "bg" })
hi("Normal", { guibg = "#1D1D1D", gui = "NONE" })
hi("Pmenu",  { guifg = "#F6F3E8", guibg = "#242829" })
hi("PmenuSel", { guifg = "#000000", guibg = "#cae682" })
hi("SignColumn", { guibg="#1D1D1D" })
hi("TabLineSel", { guifg = "#D4EB9C" })
hi("VertSplit", { guifg = "#181B22", guibg="bg", gui = "NONE" })
hi("Visual",  { guifg = "NONE", guibg = "#1F4457", gui = "none" })
hi("WildMenu", { guifg = "#E04331", guibg = "bg" })

-- Warnings and Errors
hi("Error", { guifg="#F11818", guibg = "bg" })
hi("Warning", { guifg = "#E7F6DA", guibg = "#3A0505" })
hi("WarningMsg", { guifg = "#F11818", guibg = "bg" })

-- Status Line
hi("StatusLine", { guifg = "#666666", guibg = "bg", gui = "NONE" })
hi("StatusLineFile",  { guibg = "bg" })
hi("StatusLineFileType", { guifg = "#8AC6F2", guibg = "bg" })
hi("StatusLineGit", { guifg = "#D4EB9C", guibg = "bg" })
hi("StatusLineNC", { guifg = "bg", guibg = "bg" })

-- Diff highlighting
hi("DiffAdd", { guibg = "#D1FFB6", guifg = "#080C06" })
hi("DiffChange", { guibg = "#0F1308", guifg = "NONE" })
hi("DiffDelete", { guibg = "#290700", guifg = "#290700" })
hi("DiffText",  { guibg = "#D1FFB6", guifg = "#080C06" })

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
hi("GitGutterDelete", { guifg = "#F11818" })
hi("GitGutterDeleteLine", { guibg = "#191919" })
