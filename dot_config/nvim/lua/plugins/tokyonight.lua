vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim", version = "v4.14.1" },
}, { confirm = false })

require("tokyonight").setup({
    light_style = "day",
    style = "night",
    styles = { sidebars = "transparent" },
    transparent = true,
})
