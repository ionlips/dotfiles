return {
    "folke/snacks.nvim",
    opts = {
        dashboard = { enabled = false }, -- Prefer dashboard-nvim over this.
        picker = {
            hidden = true,
            sources = {
                explorer = { hidden = true },
                files = { hidden = true },
            },
        },
    },
}
