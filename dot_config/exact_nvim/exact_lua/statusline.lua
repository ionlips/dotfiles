-- Derive the highlights from the colour scheme, and again whenever it is
-- reloaded, as that clears them.
local function set_highlights()
    local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
    local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
    local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
    vim.api.nvim_set_hl(0, "StlMode", { fg = pms.fg, bg = vis.bg })
    vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })
end
set_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("statusline_highlights", { clear = true }),
    callback = set_highlights,
})

local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    ["\22"] = "V-BLOCK",
    c = "COMMAND",
    t = "TERMINAL",
    R = "REPLACE",
    s = "SELECT",
    S = "S-LINE",
    ["\19"] = "S-BLOCK",
}

function _G._statusline()
    local mode = modes[vim.fn.mode()] or vim.fn.mode():upper()
    local branch = vim.b.git_branch and "%#StlGit# " .. vim.b.git_branch .. " %*" or ""
    local path = vim.b.rel_path or "%f"

    local diag = ""
    local counts = vim.diagnostic.count(0) or {}
    local labels = { " ", " ", " ", " " }
    local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
    for i = 1, 4 do
        if counts[i] and counts[i] > 0 then
            diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
        end
    end

    return "%#StlMode# " .. mode .. " %*" .. branch .. " " .. path .. "%=" .. diag .. vim.bo.filetype .. " %l:%c"
end

-- Read the branch from the repository's `HEAD` rather than running `git`,
-- which is slow on network filesystems. In a worktree or submodule, `.git` is
-- a file that points to the actual Git directory.
local function git_branch(root)
    local git = root .. "/.git"
    if vim.fn.filereadable(git) == 1 then
        local dir = (vim.fn.readfile(git, "", 1)[1] or ""):match("^gitdir: (.+)$")
        if not dir then
            return nil
        end
        git = dir:sub(1, 1) == "/" and dir or root .. "/" .. dir
    end
    if vim.fn.filereadable(git .. "/HEAD") == 0 then
        return nil
    end
    local head = vim.fn.readfile(git .. "/HEAD", "", 1)[1] or ""
    -- A branch, or a commit (shortened) when detached.
    return head:match("^ref: refs/heads/(.+)$") or head:sub(1, 7)
end

-- The repository is found once per buffer, from the buffer's own path. The
-- branch is reread on entering a buffer, or Neovim, in case it changed.
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = vim.api.nvim_create_augroup("statusline_git", { clear = true }),
    callback = function(ev)
        local buf = ev.buf
        local path = vim.api.nvim_buf_get_name(buf)
        if vim.bo[buf].buftype ~= "" or path == "" then
            return
        end

        local root = vim.b[buf].git_root
        if root == nil then
            root = vim.fs.root(buf, ".git") or false
            vim.b[buf].git_root = root
        end

        if root then
            vim.b[buf].git_branch = git_branch(root)
            vim.b[buf].rel_path = path:sub(#root + 2)
        else
            vim.b[buf].git_branch = nil
            vim.b[buf].rel_path = vim.fn.fnamemodify(path, ":~")
        end
    end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
    callback = function()
        vim.cmd("redrawstatus!")
    end,
})

vim.o.statusline = "%!v:lua._statusline()"
