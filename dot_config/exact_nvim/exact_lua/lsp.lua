-- lsp
-- Each is configured in `lsp/`. Only enable those that are installed, as
-- Neovim warns about the rest whenever a matching file is opened. (A server
-- installed later, e.g. via `module load`, needs Neovim to be restarted.)
vim.lsp.enable(vim.tbl_filter(function(name)
    local cmd = vim.lsp.config[name].cmd
    return type(cmd) ~= "table" or vim.fn.executable(cmd[1]) == 1
end, { "clangd", "lua_ls", "ruff" }))
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

vim.cmd("set completeopt+=noselect")
