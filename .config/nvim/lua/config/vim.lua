local options = vim.o
local command = vim.cmd

local keybinds = require "config.keybinds"

keybinds.common()

options.guifont = "DankMono Nerd Font:h14"
options.clipboard = "unnamedplus"

options.updatetime = 100
options.scrolloff = 999

options.tabstop = 4
options.colorcolumn = "120"
options.shiftwidth = 4
options.expandtab = true
options.signcolumn = "yes"

options.number = true
options.relativenumber = true

options.listchars = "eol:↴,tab:>·,trail:~,extends:>,precedes:<,space:·"
options.list = true

options.background = "dark"
options.termguicolors = true

options.completeopt = "menuone,noselect"

--options.swap = false
options.swapfile = false
options.autoread = true

command("match errorMsg /\\s\\+$/")
command("set wrap linebreak")
