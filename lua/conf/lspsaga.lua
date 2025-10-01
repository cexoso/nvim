local lspsaga = require 'lspsaga'

lspsaga.setup {
  ui = {
    code_action = '',
    devicon = true,
  },
  symbol_in_winbar = {
    enable = false
  },
  border = 'single',
  hover = {
    max_width = 0.9,
    max_height = 0.8,
    open_link = 'gx' ,
    open_cmd = '!chrome',
  }
}
