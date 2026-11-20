vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

local function close_buffer()
    if vim.bo.buftype ~= "" or vim.bo.filetype == "netrw" then
        vim.cmd("quit")
        return
    end

    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].modified then
        vim.notify("E89: no write since last change", vim.log.levels.ERROR)
        return
    end

    local alt = vim.fn.bufnr("#")
    if alt ~= -1 and alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.cmd("buffer #")
    else
        vim.cmd("enew")
        vim.bo.bufhidden = "wipe"
    end

    if vim.api.nvim_buf_is_valid(buf) then
        vim.cmd("bdelete " .. buf)
    end
end

vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true })
vim.keymap.set("n", "<leader>q", close_buffer)
