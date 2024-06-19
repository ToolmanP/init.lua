return {
  setup = function()
    require('editor.builtin.options').setup()
    require('editor.builtin.keymaps').setup()
    require('editor.builtin.autocmd').setup()
    require 'editor.builtin.health'
  end,
}
