return function(use)
  use "alvan/vim-closetag"
  vim.g.closetag_filetypes = "eruby,html,javascript,javascript.jsx,xhtml"
  vim.g.closetag_regions = {
    ["typescript.tsx"] = "jsxRegion,tsxRegion,litHtmlRegion",
    ["javascript.jsx"] = 'jsxRegion,litHtmlRegion',
    ["javascipt"] = "litHtmlRegion",
    ["typescript"] =  "litHtmlRegion"
  }
end
