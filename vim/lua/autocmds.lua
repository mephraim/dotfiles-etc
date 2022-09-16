local macroRecordingGroup = vim.api.nvim_create_augroup(
  "MacroRecording", { clear = true })

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    vim.notify(
      'Started recording into register ' .. vim.fn.reg_recording(),
      vim.log.levels.WARN, {
        title = "Recording macro",
        timeout = 100
      })
  end,

  group = macroRecordingGroup,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    vim.notify(
      "Replay it with @" .. vim.fn.reg_recording(),
      vim.log.levels.INFO, {
        title = "Done recording macro",
        timeout = 100
      })
  end,

  group = macroRecordingGroup
})
