return function(use)
  use "alvan/vim-closetag"
  vim.g.closetag_filetypes = "eruby,html,javascript,javascript.jsx,xhtml"
  vim.g.closetag_regions = {
    ["typescript.tsx"] = "jsxRegion,tsxRegion,litHtmlRegion",
    ["javascript.jsx"] = 'jsxRegion,litHtmlRegion',
    ["javascipt"] = "litHtmlRegion",
    ["typescript"] =  "litHtmlRegion"
  }

  -- Highlight closing quotes, parens, tags, etc
  use "andymass/vim-matchup"
  vim.g.matchup_matchparen_offscreen = { method = "popup" }

  -- Highlight the closing tag
  -- This plugin handles some extra cases that Matchup doesn't handle yet.
  use "Valloric/MatchTagAlways"
  vim.g.mta_filetypes = {
    ["html"] = 1,
    ["xhtml"] = 1,
    ["xml"] = 1,
    ["eruby"] = 1,
    ["javascript"] = 1
  }
end
