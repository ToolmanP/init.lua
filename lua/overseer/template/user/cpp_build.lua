return {
  name = 'Make',
  builder = function()
    -- Full path to current file (see :help expand())
    return {
      cmd = { 'make' },
      components = { { 'on_output_quickfix', open = true }, 'default' },
    }
  end,
  condition = {
  },
}
