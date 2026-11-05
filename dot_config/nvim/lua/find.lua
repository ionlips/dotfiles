local files
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = vim.api.nvim_create_augroup("find_files", { clear = true }),

    callback = function()
        files = nil
    end,
})
function _G.native_find(text, _)
    if not files then
        files = vim.fn.systemlist({
            "fd",
            "--color=never",
            "--exclude=.git",
            "--hidden",
            "--type=file",
        })
        if vim.v.shell_error ~= 0 then
            files = {}
        end
    end
    if text == "" then
        return files
    end
    return vim.fn.matchfuzzy(files, text)
end
vim.opt.findfunc = "v:lua.native_find"
vim.keymap.set("n", "<leader>f", ":find ", { silent = false })
