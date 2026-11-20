local winsize = 25

vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = winsize
vim.g.netrw_browse_split = 0
vim.g.netrw_altfile = 1

vim.keymap.set("n", "<leader>e", ":Lexplore<cr>", { silent = true })
vim.keymap.set("n", "<leader>r", "<Plug>NetrwRefresh", { remap = true })

local function is_floating(win)
    return vim.api.nvim_win_get_config(win).relative ~= ""
end

local function is_empty(buf)
    return vim.api.nvim_buf_get_name(buf) == ""
        and not vim.bo[buf].modified
        and vim.api.nvim_buf_line_count(buf) == 1
        and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
end

local function open_beside(netrw, buf)
    if buf then
        vim.cmd("rightbelow vertical sbuffer " .. buf)
    else
        vim.cmd("rightbelow vnew")
        vim.bo.bufhidden = "wipe"
    end
    vim.api.nvim_win_set_width(
        netrw,
        math.floor(vim.o.columns * winsize / 100)
    )
end

local function replace_closed(netrw, buf, was_empty)
    if not was_empty then
        open_beside(netrw)
        if
            vim.api.nvim_buf_is_valid(buf)
            and not vim.bo[buf].modified
            and #vim.fn.win_findbuf(buf) == 0
        then
            vim.cmd.bdelete(buf)
        end
        return
    end

    local ok, err = pcall(vim.cmd.quit)
    if ok then
        return
    end

    vim.notify(err, vim.log.levels.ERROR)
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[b].modified then
            open_beside(netrw, b)
            return
        end
    end
    open_beside(netrw)
end

local function on_win_closed(ev)
    local closed = tonumber(ev.match)
    if is_floating(closed) then
        return
    end

    local buf = vim.api.nvim_win_get_buf(closed)
    if vim.bo[buf].filetype == "netrw" then
        vim.schedule(function()
            vim.g.netrw_winsize = winsize
        end)
        return
    end

    local was_empty = is_empty(buf)
    vim.schedule(function()
        local wins = vim.tbl_filter(function(win)
            return not is_floating(win)
        end, vim.api.nvim_tabpage_list_wins(0))
        local netrw = wins[1]
        if
            #wins == 1
            and vim.api.nvim_win_get_buf(netrw) == vim.t.netrw_lexbufnr
        then
            replace_closed(netrw, buf, was_empty)
        end
    end)
end

vim.api.nvim_create_autocmd("WinClosed", {
    group = vim.api.nvim_create_augroup("netrw_lexplore", { clear = true }),
    callback = on_win_closed,
})
