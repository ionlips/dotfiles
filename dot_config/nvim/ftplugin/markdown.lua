-- Mappings for notes in a zk notebook. Does nothing without zk-nvim, e.g. on
-- remote systems.
local ok, util = pcall(require, "zk.util")
if ok and util.notebook_root(vim.fn.expand("%:p")) ~= nil then
    local function map(...)
        vim.api.nvim_buf_set_keymap(0, ...)
    end
    local opts = { noremap = true, silent = false }

    -- Open the link under the caret.
    map("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)

    -- Open notes linking to the current buffer.
    map("n", "<leader>zb", "<Cmd>ZkBacklinks<CR>", opts)

    -- Open notes linked by the current buffer.
    map("n", "<leader>zl", "<Cmd>ZkLinks<CR>", opts)

    -- Preview a linked note.
    map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
end
