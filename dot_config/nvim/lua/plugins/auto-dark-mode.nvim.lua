return {
    "f-person/auto-dark-mode.nvim",
    opts = {
        set_dark_mode = function()
            vim.o.background = "dark"
            vim.cmd.colorscheme("tokyonight-night")
        end,
        set_light_mode = function()
            vim.o.background = "light"
            vim.cmd.colorscheme("tokyonight-day")
        end,
    },
}
