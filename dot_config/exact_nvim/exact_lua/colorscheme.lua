-- Keep the background transparent, including when the colour scheme is
-- reloaded, e.g. when auto-dark-mode.nvim changes 'background'.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("transparent_background", { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    end,
})

-- Catppuccin Latte for light backgrounds and Mocha for dark.
vim.cmd.colorscheme("catppuccin")
