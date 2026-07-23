return {
    "zk-org/zk-nvim",
    keys = {

        -- Search for the notes matching a given query.
        {
            "<leader>zf",
            "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
            desc = "Search notes",
            silent = false,
        },

        -- Search for the notes matching the current visual selection.
        {
            "<leader>zf",
            ":'<,'>ZkMatch<CR>",
            desc = "Search notes (selection)",
            mode = "v",
            silent = false,
        },

        -- Create a new note after asking for its title.
        {
            "<leader>zn",
            "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>",
            desc = "New note",
            silent = false,
        },

        -- Open notes.
        {
            "<leader>zo",
            "<Cmd>ZkNotes { sort = { 'modified' } }<CR>",
            desc = "Open notes",
            silent = false,
        },

        -- Open notes associated with the selected tags.
        {
            "<leader>zt",
            "<Cmd>ZkTags<CR>",
            desc = "Open notes by keyword/tag",
            silent = false,
        },

        -- Open or create today's daily note.
        {
            "<leader>zd",
            "<Cmd>ZkNew { dir = 'journal/daily' }<CR>",
            desc = "Create (or open, if exists) daily note",
            silent = false,
        },
    },
    name = "zk",
    opts = { picker = "snacks_picker" },
}
