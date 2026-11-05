-- Based on <https://github.com/smnatale/nvim_native>: a configuration with no
-- plugins, built on Neovim's native features.

vim.g.mapleader = " "

require("options")
require("netrw")
require("statusline")
require("find")
require("grep")
require("autocommands")
require("diagnostics")
require("formatting")
require("keymaps")

-- Plugins, managed by `vim.pack`. Each file in `lua/plugins` adds and sets up
-- one. Only some are installed on remote systems (see `.chezmoiignore.tmpl`).
local plugins = vim.fn.stdpath("config") .. "/lua/plugins"
for _, file in ipairs(vim.fn.glob(plugins .. "/*.lua", false, true)) do
    require("plugins." .. vim.fn.fnamemodify(file, ":t:r"))
end

-- After the plugins, as these use nvim-lspconfig and tokyonight.
require("colorscheme")
require("lsp")
