vim.pack.add({ "https://github.com/zk-org/zk-nvim" }, { confirm = false })
require("zk").setup({ picker = "select" })
local function map(lhs, rhs, desc, mode)
    vim.keymap.set(mode or "n", lhs, rhs, { desc = desc })
end
map(
    "<leader>zf",
    "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
    "Search notes"
)
map("<leader>zf", ":'<,'>ZkMatch<CR>", "Search notes (selection)", "v")
map(
    "<leader>zm",
    "<Cmd>ZkNew { dir = 'meetings', template = 'meeting.md', title = vim.fn.input('Title: ') }<CR>",
    "New meeting note"
)
map(
    "<leader>zn",
    "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
    "New note"
)
map("<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", "Open notes")
map("<leader>zt", "<Cmd>ZkTags<CR>", "Open notes by keyword/tag")
map(
    "<leader>zd",
    "<Cmd>ZkNew { dir = 'journal/daily' }<CR>",
    "Create (or open, if exists) daily note"
)
