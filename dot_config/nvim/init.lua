vim.g.mapleader = " "

require("autocommands")
require("diagnostics")
require("find")
require("grep")
require("keymaps")
require("netrw")
require("options")
require("statusline")

local plugins = vim.fn.stdpath("config") .. "/lua/plugins"

for _, file in ipairs(vim.fn.glob(plugins .. "/*.lua", false, true)) do
    require("plugins." .. vim.fn.fnamemodify(file, ":t:r"))
end

require("colorscheme")
require("lsp")
