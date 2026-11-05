vim.pack.add({ "https://github.com/folke/tokyonight.nvim" }, { confirm = false })

-- The style follows 'background': "night" when dark and "day" when light.
require("tokyonight").setup({
    light_style = "day",
    style = "night",
    styles = { sidebars = "transparent" },
    transparent = true,
})
