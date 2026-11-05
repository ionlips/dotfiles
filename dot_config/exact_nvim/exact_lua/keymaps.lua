-- Write and quit
vim.keymap.set("n", "<leader>w", ":w<cr>", { silent = true })

-- Close the buffer but keep the window, so e.g. netrw isn't maximised. Special
-- windows (netrw, help, quickfix) are closed as usual.
vim.keymap.set("n", "<leader>q", function()
    if vim.bo.buftype ~= "" then
        vim.cmd("quit")
        return
    end
    local buf = vim.api.nvim_get_current_buf()
    local alt = vim.fn.bufnr("#")
    if alt ~= -1 and alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.cmd("buffer #")
    else
        vim.cmd("enew")
    end
    vim.cmd("bdelete " .. buf)
end, { silent = true, desc = "Close buffer, keep window" })

-- Redo
vim.keymap.set("n", "U", "<c-r>", { silent = true })

-- Swap between split buffers
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Move to right split" })
