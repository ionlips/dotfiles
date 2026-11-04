vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup(
        "no_format_third_party",
        { clear = true }
    ),
    pattern = "*/third-party/*",
    callback = function(ev)
        vim.b[ev.buf].autoformat = false
        vim.diagnostic.enable(false, { bufnr = ev.buf })
    end,
})
