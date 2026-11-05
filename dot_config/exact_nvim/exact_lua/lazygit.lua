-- Open lazygit in a floating terminal, closing it when lazygit exits. Files
-- edited from lazygit open in this Neovim (see `~/.config/lazygit`).
local function lazygit()
    if vim.fn.executable("lazygit") == 0 then
        vim.notify("lazygit is not installed", vim.log.levels.WARN)
        return
    end

    local width = math.floor(vim.o.columns * 0.9)
    local height = math.floor(vim.o.lines * 0.9)
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
        border = "rounded",
        col = math.floor((vim.o.columns - width) / 2),
        height = height,
        relative = "editor",
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        width = width,
    })

    vim.fn.jobstart({ "lazygit" }, {
        on_exit = function()
            -- A file opened from lazygit may land in the float before it
            -- closes, so show it in the window underneath instead.
            local opened
            if vim.api.nvim_win_is_valid(win) then
                local current = vim.api.nvim_win_get_buf(win)
                opened = current ~= buf and current or nil
                vim.api.nvim_win_close(win, true)
            end
            if opened then
                vim.api.nvim_set_current_buf(opened)
            end
            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
            -- Reload any files that lazygit changed, e.g. by checking out.
            vim.cmd.checktime()
        end,
        term = true,
    })
    vim.cmd.startinsert()
end

vim.keymap.set("n", "<leader>gg", lazygit, { desc = "Lazygit" })
