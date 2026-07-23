return {
    "nvimdev/dashboard-nvim",
    lazy = false, -- See <https://github.com/nvimdev/dashboard-nvim/pull/450>.
    opts = function()
        local opts = {
            config = {

                -- Centre of the dashboard.
                center = {
                    {
                        action = "lua LazyVim.pick()()",
                        desc = " Find file",
                        icon = " ",
                        key = "f",
                    },
                    {
                        action = "ene | startinsert",
                        desc = " New file",
                        icon = " ",
                        key = "n",
                    },
                    {
                        action = 'lua LazyVim.pick("oldfiles")()',
                        desc = " Recent files",
                        icon = " ",
                        key = "r",
                    },
                    {
                        action = 'lua LazyVim.pick("live_grep")()',
                        desc = " Find text",
                        icon = " ",
                        key = "g",
                    },
                    {
                        action = "lua LazyVim.pick.config_files()()",
                        desc = " Configuration",
                        icon = " ",
                        key = "c",
                    },
                    {
                        action = 'lua require("persistence").load()',
                        desc = " Restore session",
                        icon = " ",
                        key = "s",
                    },
                    {
                        action = "LazyExtras",
                        desc = " LazyVim extras",
                        icon = " ",
                        key = "x",
                    },
                    {
                        action = "Lazy",
                        desc = " lazy.nvim",
                        icon = "󰒲 ",
                        key = "l",
                    },
                    {
                        action = function()
                            vim.api.nvim_input("<cmd>qa<cr>")
                        end,
                        desc = " Quit",
                        icon = " ",
                        key = "q",
                    },
                },

                -- Footer (i.e., bottom) of the dashboard.
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (
                        math.floor(stats.startuptime * 100 + 0.5) / 100
                    )
                    return {
                        "Neovim loaded "
                            .. stats.loaded
                            .. "/"
                            .. stats.count
                            .. " plugins in "
                            .. ms
                            .. "ms",
                    }
                end,

                -- Header (i.e., top) of the dashboard.
                header = {},
                vertical_center = true,
            },
            theme = "doom",
            hide = {
                statusline = false,
            },
        }
        for _, button in ipairs(opts.config.center) do
            button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
            button.key_format = "  %s"
        end

        -- Action keys on dashboard are rendered horizontally on the left on
        -- the first Neovim instance.
        vim.api.nvim_create_autocmd("User", {
            pattern = "DashboardLoaded",
            group = vim.api.nvim_create_augroup(
                "DashboardDoomStaleKeys",
                { clear = true }
            ),
            callback = function()
                local buf = vim.api.nvim_get_current_buf()
                if vim.bo[buf].filetype ~= "dashboard" then
                    return
                end
                local ns = vim.api.nvim_create_namespace("DashboardDoom")
                for _, mark in
                    ipairs(vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {}))
                do
                    local id, row = mark[1], mark[2]
                    local line = vim.api.nvim_buf_get_lines(
                        buf,
                        row,
                        row + 1,
                        false
                    )[1] or ""
                    if not line:find("%w") then
                        vim.api.nvim_buf_del_extmark(buf, ns, id)
                    end
                end
            end,
        })

        -- Open the dashboard when lazy.nvim is closed.
        if vim.o.filetype == "lazy" then
            vim.api.nvim_create_autocmd("WinClosed", {
                pattern = tostring(vim.api.nvim_get_current_win()),
                once = true,
                callback = function()
                    vim.schedule(function()
                        vim.api.nvim_exec_autocmds(
                            "UIEnter",
                            { group = "dashboard" }
                        )
                    end)
                end,
            })
        end

        return opts
    end,
}
