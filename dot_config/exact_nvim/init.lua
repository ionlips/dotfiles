-- Based on <https://github.com/smnatale/nvim_native>: a configuration with no
-- plugins, built on Neovim's native features.

vim.g.mapleader = " "

require("options")
require("lsp")
require("colorscheme")
require("netrw")
require("statusline")
require("find")
require("grep")
require("autocommands")
require("diagnostics")
require("formatting")
require("keymaps")
