vim.pack.add({
    { src = "https://github.com/zk-org/zk-nvim", version = "v0.5.3" },
}, { confirm = false })

require("zk").setup({ picker = "select" })

local function map(lhs, rhs, mode)
    vim.keymap.set(mode or "n", lhs, rhs)
end

local function input(prompt)
    local value = vim.fn.input(prompt)
    if value ~= "" then
        return value
    end
end

local function new_note(opts)
    require("zk.commands").get("ZkNew")(opts)
end

local function new_meeting()
    local time = vim.fn.input("time (hh:mm): ")
    local hour, minute = time:match("^(%d%d?):(%d%d)$")
    if not hour then
        vim.notify("invalid time: " .. time, vim.log.levels.ERROR)
        return
    end

    local title = input("title: ")
    if not title then
        return
    end

    new_note({
        dir = "meetings",
        title = title,
        extra = { time = string.format("%02d:%s", tonumber(hour), minute) },
    })
end

local function new_plain()
    local title = input("title: ")
    if title then
        new_note({ title = title })
    end
end

local function new_person()
    local name = input("name (first name surname): ")
    if name then
        new_note({ dir = "rolodex", title = name })
    end
end

local function new_daily()
    local title = os.date("%A, %B ")
        .. tonumber(os.date("%d"))
        .. os.date(", %Y")
    new_note({ dir = "journal/daily", title = title:lower() })
end

local function new_session(type, series)
    local title = input("title: ")
    if not title then
        return
    end

    local dir = "sessions/" .. type
    if series then
        local util = require("zk.util")
        local root = util.notebook_root(util.resolve_notebook_path(0))
        if not root then
            vim.notify("no zk notebook found", vim.log.levels.ERROR)
            return
        end
        dir = dir
            .. "/"
            .. series:lower():gsub("%W+", "-"):gsub("^-+", ""):gsub("-+$", "")
        vim.fn.mkdir(root .. "/" .. dir, "p")
    end

    new_note({
        dir = dir,
        title = title,
        extra = { type = type, series = series },
    })
end

local function list_series()
    local names = vim.fn.systemlist({
        "zk",
        "list",
        "sessions/series",
        "--quiet",
        "--format",
        "{{metadata.series}}",
    })

    local seen, items = {}, {}
    for _, name in ipairs(names) do
        if vim.v.shell_error == 0 and name ~= "" and not seen[name] then
            seen[name] = true
            table.insert(items, name)
        end
    end
    table.sort(items)
    return items
end

local function pick_series(callback)
    local items = list_series()
    if #items == 0 then
        local series = input("series title: ")
        if series then
            callback(series)
        end
        return
    end

    local new = "[new series]"
    table.insert(items, new)
    vim.ui.select(items, { prompt = "series:" }, function(choice)
        if choice == new then
            choice = input("series title: ")
        end
        if choice then
            callback(choice)
        end
    end)
end

local function pick_session()
    vim.ui.select(
        { "standalone", "series" },
        { prompt = "type:" },
        function(type)
            if type == "standalone" then
                new_session(type)
            elseif type == "series" then
                pick_series(function(series)
                    new_session(type, series)
                end)
            end
        end
    )
end

map(
    "<leader>zf",
    "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('search: ') } }<CR>"
)
map("<leader>zf", ":'<,'>ZkMatch<CR>", "v")
map("<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>")
map("<leader>zt", "<Cmd>ZkTags<CR>")

map("<leader>zd", new_daily)
map("<leader>zm", new_meeting)
map("<leader>zn", new_plain)
map("<leader>zp", new_person)
map("<leader>zs", pick_session)
