return {
    "folke/snacks.nvim",
    opts = {
        dashboard = { enabled = false }, -- Prefer dashboard-nvim over this.
        picker = {
            hidden = true,
            ignored = true,
            sources = {
                explorer = { hidden = true, ignored = true },
                files = { hidden = true, ignored = true },
            },
        },
    },
}
