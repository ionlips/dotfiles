vim.lsp.enable(vim.tbl_filter(function(name)
    local cmd = vim.lsp.config[name].cmd
    return type(cmd) ~= "table" or vim.fn.executable(cmd[1]) == 1
end, { "clangd", "lua_ls", "ruff" }))

vim.opt.completeopt:append("noselect")

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if
            client ~= nil and client:supports_method("textDocument/completion")
        then
            vim.lsp.completion.enable(
                true,
                client.id,
                ev.buf,
                { autotrigger = true }
            )
        end
    end,
})
