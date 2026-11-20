vim.g.mapleader = " "

require("options")
require("clipboard")
require("keymaps")
require("autocommands")

require("diagnostics")
require("find")
require("grep")
require("netrw")
require("statusline")

require("plugins.conform")
require("plugins.gitsigns")
require("plugins.lspconfig")
if #vim.api.nvim_get_runtime_file("lua/plugins/zk.lua", false) > 0 then
    require("plugins.zk")
end

require("lsp")
