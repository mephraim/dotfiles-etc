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
  dark_gray = "#313131",
  gray = "#828282",
  green = "#8F9D6A",
  light_blue = "#AFC4DB",
  light_gray = "#666666",
  light_green = "#DAEFA3",
  light_orange = "#CDA869",
  light_red = "#E04331",
  light_yellow = "#F9EE98",
  middle_gray = "#2A2A2A",
  very_light_gray = "#929292",
  orange = "#F5773C",
  red = "#F11818",
  salmon = "#CF6A4C",
  yellow = "#EEEE00",
  white = "#FFFFFF"
}

-- Syntax
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua
hi("Boolean", { fg = colors.light_red, underline = true })
hi("TSBoolean", { fg = colors.light_red, underline = true })

hi("Comment", { fg = colors.gray, italic = true })
hi("TSComment", { fg = colors.gray, italic = true })
hi("@comment", { fg = colors.light_gray, italic = true })

hi("Constant", { fg = colors.salmon })
hi("TSConstant", { fg = colors.light_red })

hi("Define", { fg = colors.light_orange })
hi("TSDefine", { fg = colors.light_orange })

hi("Function", { fg = colors.brown })
hi("TSFunction", { fg = colors.brown })

hi("Identifier", { fg = colors.blue })
hi("TSField", { fg = colors.blue })
hi("TSSymbol", { fg = colors.blue })

hi("TSParameter", { fg = colors.light_blue })
hi("@variable.parameter", { fg = colors.light_blue })
hi("@variable", { fg = colors.light_yellow })

hi("TSProperty", { fg = colors.blue })
hi("@property", { fg = colors.blue })

hi("Ignore", { fg = colors.light_gray })

hi("PreProc", { fg = colors.light_blue })
hi("TSPreProc", { fg = colors.light_blue })
hi("TSAnnotation", { fg = colors.light_blue })
hi("TSAttribute", { fg = colors.light_blue })

hi("Special", { fg = colors.light_green })
hi("TSCharacterSpecial", { fg = colors.light_green })
hi("TSConstBuiltin", { fg = colors.light_green })
hi("TSConstructor", { fg = colors.light_green })
hi("TSFuncBuiltin", { fg = colors.light_green })
hi("TSMath", { fg = colors.light_green })
hi("TSPunctSpecial", { fg = colors.light_green })
hi("TSStringSpecial", { fg = colors.light_green })
hi("TSVariableBuiltin", { fg = colors.light_green })

hi("Statement", { fg = colors.light_orange })
hi("TSString", { fg = colors.green })
hi("TSStringRegex", { fg = colors.green })
hi("TSLiteral", { fg = colors.green })
hi("@string", { fg = colors.green })

hi("Todo", { fg = colors.yellow, bg = colors.black, underline = true })
hi("TSTodo", { fg = colors.yellow, bg = colors.black, underline = true })
hi("TSWarning", { fg = colors.yellow, bg = colors.black, underline = true })

hi("Type", { fg = colors.light_yellow })
hi("TSEnvironmentName", { fg = colors.light_yellow })
hi("TSType", { fg = colors.light_yellow })
hi("TSTypeBuiltin", { fg = colors.light_yellow })
hi("TSTypeQualifier", { fg = colors.light_yellow })

hi("TSKeywordReturn", { fg = colors.salmon, italic = true })


-- HTML
hi("@tag", { fg = colors.light_orange })
hi("@tag.attribute", { fg = colors.brown })
hi("@tag.delimiter", { fg = colors.orange })
hi("@punctuation.special", { fg = colors.green })

-- Hide NonText characters by default.
-- There's function that will make them visible in .vimrc.
hi("NonText", { fg = colors.dark_gray })

 -- UI Elements
hi("ColorColumn", { bg = "#130707" })
hi("Conceal", { fg = colors.white, bg = colors.bg })
hi("Cursor",  { fg = colors.bg, bg = colors.orange })
hi("CursorColumn", { bg = "#2D2D2D" })
hi("CursorLine", { bg = "#131313", bold = true })
hi("Directory", { fg = "#CFCFCF" })
hi("FoldColumn", { fg = "#444444", bg = colors.bg })
hi("Folded",  { bg = colors.bg, fg = "#434343", italic = true })
hi("LineNr", { bg = colors.bg, fg = "#434343" })
hi("MatchParen",  { fg= colors.red, bg = colors.bg })
hi("Normal", { bg = colors.bg })
hi("Pmenu",  { fg = "#F6F3E8", bg = "#242829" })
hi("PmenuSel", { fg = "#000000", bg = colors.light_green })
hi("CurSearch", { bg = colors.orange, fg = colors.bg })
hi("Search", { bg = colors.light_green, fg = colors.bg })
hi("SignColumn", { bg = colors.bg })
hi("TabLineSel", { fg = colors.light_green })
hi("Visual",  { fg = "NONE", bg = "#1F4457", })
hi("WildMenu", { fg = colors.light_red, bg = colors.bg })
hi("WinSeparator", { fg = "#181B22", bg = colors.bg })

-- LSP
hi("LspInlayHint", { fg = colors.light_gray, bg = "bg", italic = true, underline = true, sp = colors.dark_gray })

-- Warnings and Errors
hi("DiagnosticError", { fg = colors.light_red })
hi("DiagnosticUnderlineError", { sp = colors.light_red, undercurl = true })
hi("DiagnosticWarn", { fg = colors.light_orange })
hi("DiagnosticUnderlineWarn", { sp = colors.light_orange, undercurl = true })
hi("DiagnosticInfo", { fg = colors.light_green })
hi("DiagnosticHint", { fg = colors.light_blue, italic = true })
hi("DiagnosticUnderlineHint", { sp = colors.light_blue, undercurl = true })
hi("Error", { fg = colors.red })
hi("Warning", { fg = colors.orange })
hi("WarningMsg", { fg = colors.light_yellow })

-- Status Line
hi("StatusLine", { fg = colors.light_gray, bg = colors.bg })
hi("StatusLineFile",  { bg = colors.bg })
hi("StatusLineFileType", { fg = "#8AC6F2", bg = colors.bg })
hi("StatusLineGit", { fg = "#D4EB9C", bg = colors.bg })
hi("StatusLineNC", { fg = "bg", bg = colors.bg })

-- Diff highlighting
hi("DiffAdd", { bg = "#012800" })
hi("DiffChange", { bg = "#473100" })
hi("DiffDelete", { fg = colors.salmon })
hi("DiffText",  { bg = colors.green, fg = "#080C06" })

-- Terminal colors
hi("Terminal", { bg = "#111720" })

-- Spelling
hi("SpellBad", { fg = "red", undercurl = true })

-- Floats
hi("FloatBorder", { fg = colors.very_light_gray })
hi("FloatTitle", { fg = colors.blue, bg = colors.middle_gray })
hi("NormalFloat", { bg = bg })
hi("NormalFloatDoc", { fg = fg })

-- Noice
hi("NoiceBorder", { fg = "#2A2A2A", bg = "#2A2A2A" })
hi("NoiceCmdlinePopupBorderCmdline", { fg = colors.very_light_gray, bg = bg, blend = 1 })
hi("NoiceCmdlinePopupBorderFilter", { fg = "#2A2A2A", bg = "#2A2A2A" })
hi("NoiceCmdlinePopupBorderLua", { fg = colors.very_light_gray, bg = bg, blend = 1 })
hi("NoiceCmdlinePopupBorderSearch", { fg = colors.very_light_gray, bg = bg, blend = 1 })
hi("NoiceFloat", { bg = "#2A2A2A" })
hi("NoiceMini", { fg = colors.white, bg = "#2A2A2A" })

-- Code Companion
hi("CodeCompanionChatHeader", { fg = colors.light_blue, nocombine = true })

-- HTML
hi("@text.title", { fg = colors.green, bold = true })

-- Markdown
hi("markdownError", { fg = "None", bg = "None" })
hi("@markup.raw.block.markdown", { fg = colors.gray })
hi("@markup.heading.1.markdown", { fg = colors.brown, sp = colors.light_gray })
hi("@markup.heading.2.markdown", { fg = colors.light_orange, sp = colors.light_gray })
hi("@markup.heading.3.markdown", { fg = colors.light_orange, sp = colors.light_gray })
hi("@markup.heading.4.markdown", { fg = colors.light_yellow, sp = colors.light_gray })

-- Mini
hi("MiniIndentscopeSymbol", { fg = "#444444" })

-- Nvim Tree
hi("NvimTreeNormal", { bg = "#242222" })

-- Telescope
hi("TelescopeBorder", { fg = colors.middle_gray, bg = colors.middle_gray })
hi("TelescopePromptBorder", { fg = colors.middle_gray, bg = colors.middle_gray })
hi("TelescopePromptNormal", { bg = colors.middle_gray })
hi("TelescopePromptPrefix", { fg = colors.light_blue })
hi("TelescopePromptTitle", { fg = colors.middle_gray, bg = colors.light_blue })
hi("TelescopeNormal", { bg = colors.middle_gray })
hi("TelescopePreviewTitle", { fg = colors.middle_gray, bg = colors.middle_gray })
hi("TelescopeResultsTitle", { bg = colors.middle_gray })
-- hi("TelescopeSelection", { bg = colors.dark_gray })

-- Signify
hi("GitGutterAdd", { fg = "#7D8D57" })
hi("GitGutterAddLine", { bg ="#191919" })
hi("GitGutterChange", { fg = colors.orange, bg = "NONE" })
hi("GitGutterChangeDelete",  { fg = colors.orange, bg = "NONE" })
hi("GitGutterChangeDeleteLine", { bg = "#191919" })
hi("GitGutterChangeLine", { bg = "#191919" })
hi("GitGutterDelete", { fg = colors.red })
hi("GitGutterDeleteLine", { bg = "#191919" })

-- Yanky
hi("YankyPut", { bg = "#1A251A" })
hi("YankyYanked", { bg = "#1A251A" })
