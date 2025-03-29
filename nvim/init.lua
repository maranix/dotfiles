local g = vim.g
g.mapleader = vim.keycode('<space>')
g.maplocalleader = '\\'

_G.is_mac = vim.uv.os_uname().sysname == 'Darwin'

require('core')
