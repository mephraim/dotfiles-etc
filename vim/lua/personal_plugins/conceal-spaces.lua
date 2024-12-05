local conceal2SpacesEnabled = false

-- Just a little function that collapses 2 spaces down to 1 space visually.
-- Sometimes it's nice to make code look a little less indented.
--
-- This is only visual, so it shouldn't impact the underlying code.
function ToggleConceal2Spaces()
  if conceal2SpacesEnabled then
    ResetSpacesDisplay()
  else
    Conceal2Spaces()
  end
end

-- Display 2 spaces as 1
function Conceal2Spaces()
  vim.cmd [[
    syntax match twoSpaces /  / conceal cchar= "<- Intentional space after cchar.
    setlocal concealcursor=nv
    setlocal conceallevel=2
  ]]

  conceal2SpacesEnabled = true
end

-- Display 2 spaces normally
function ResetSpacesDisplay()
  if not conceal2SpacesEnabled then
    return
  end

  vim.cmd [[
    syntax clear twoSpaces
    setlocal concealcursor=
    setlocal conceallevel=0
  ]]

  conceal2SpacesEnabled = false
end

vim.keymap.set('n', '<leader>2sp', ToggleConceal2Spaces, { silent = true })

local conceal2SpacesGroup = vim.api.nvim_create_augroup(
  "Conceal2Spaces", { clear = true })

-- Turn off conceal when entering insert mode
vim.api.nvim_create_autocmd(("InsertEnter"), {
  callback = ResetSpacesDisplay,
  group = conceal2SpacesGroup,
})
