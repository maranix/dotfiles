-- Currently most of the plugins of mini.nvim are lazily loaded using keys
--
-- Sometimes, I don't really have to use them except for these plugins,
-- hence load these plugins even if i don't really trigger mini.nvim via any of
-- the defined keymaps.
require('mini.surround').setup()
require('mini.indentscope').setup()
