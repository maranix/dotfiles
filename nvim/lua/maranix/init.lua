local g = vim.g

-- map leader key to space
g.mapleader = vim.keycode('<space>')
g.maplocalleader = '\\'

require('maranix.lazy_bootstrap')
require('maranix.keymaps')
require('maranix.opts')
require('maranix.ui')