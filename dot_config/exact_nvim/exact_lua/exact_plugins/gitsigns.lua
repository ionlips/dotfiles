-- Mark added, changed, and deleted lines in the sign column, and act on the
-- hunks. Git runs in the background, so this doesn't block Neovim.
vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim", version = "v2.1.0" },
}, { confirm = false })

require("gitsigns").setup({
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation, falling back to the built-in mappings in diff mode.
        map("n", "]h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                gitsigns.nav_hunk("next")
            end
        end, "Next hunk")
        map("n", "[h", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                gitsigns.nav_hunk("prev")
            end
        end, "Previous hunk")

        -- Actions.
        map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selection")
        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selection")
        map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>hd", gitsigns.diffthis, "Diff against index")
        map("n", "<leader>hq", gitsigns.setqflist, "Hunks to quickfix")

        -- Text object for the hunk under the cursor, e.g. `dih`.
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Hunk")
    end,
})
