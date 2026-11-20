vim.pack.add({
    { src = "https://github.com/lewis6991/gitsigns.nvim", version = "v2.1.0" },
}, { confirm = false })

local function nav_hunk(direction, diff_key)
    return function()
        if vim.wo.diff then
            vim.cmd.normal({ diff_key, bang = true })
        else
            require("gitsigns").nav_hunk(direction)
        end
    end
end

require("gitsigns").setup({
    on_attach = function(bufnr)
        vim.keymap.set("n", "]h", nav_hunk("next", "]c"), { buffer = bufnr })
        vim.keymap.set("n", "[h", nav_hunk("prev", "[c"), { buffer = bufnr })
    end,
})
