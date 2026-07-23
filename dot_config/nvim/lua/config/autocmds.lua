vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
        vim.fn.cursor(1, 1)
    end,
})
