vim.pack.add({ "https://github.com/f-person/auto-dark-mode.nvim" }, {
    confirm = false,
})
require("auto-dark-mode").setup({
    set_dark_mode = function()
        vim.o.background = "dark"
    end,
    set_light_mode = function()
        vim.o.background = "light"
    end,
})
