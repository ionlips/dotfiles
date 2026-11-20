local function set_highlights()
    local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
    local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
    local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
    vim.api.nvim_set_hl(0, "StlMode", { fg = pms.fg, bg = vis.bg })
    vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })
end

set_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup(
        "statusline_highlights",
        { clear = true }
    ),
    callback = set_highlights,
})

function _G._statusline()
    local head = vim.b.gitsigns_head
    local branch = (head and head ~= "") and "%#StlGit# " .. head .. " %*"
        or ""
    return "%#StlMode# "
        .. vim.fn.mode()
        .. " %*"
        .. branch
        .. " "
        .. vim.fn.expand("%:~:.")
        .. "%="
        .. vim.diagnostic.status()
        .. " "
        .. vim.bo.filetype
        .. " %l:%c"
end

vim.o.statusline = "%!v:lua._statusline()"

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = vim.api.nvim_create_augroup("statusline_redraw", { clear = true }),
    callback = function()
        vim.cmd("redrawstatus!")
    end,
})
