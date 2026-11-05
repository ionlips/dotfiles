-- Pinned to a release, as remote systems don't get the lockfile.
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim", version = "v4.14.1" },
}, { confirm = false })

-- The style follows 'background': "night" when dark and "day" when light.
require("tokyonight").setup({
    light_style = "day",
    style = "night",
    styles = { sidebars = "transparent" },
    transparent = true,
})
