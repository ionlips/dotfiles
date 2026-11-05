-- Format on save. Each formatter reads the buffer on stdin and writes the
-- result to stdout, unless `stdin = false`, in which case it fixes a temporary
-- copy of the buffer in place. `$FILENAME` is replaced with the buffer's path
-- (or the copy's), so that formatters find their config, e.g. `.clang-format`,
-- `.editorconfig`, or `pyproject.toml`. If a filetype has no formatter, or it
-- isn't installed, the language server formats the buffer instead, if it can.

local M = {}

local clang_format = { cmd = { "clang-format", "--assume-filename=$FILENAME" } }
local prettier = { cmd = { "prettier", "--stdin-filepath", "$FILENAME" } }
local shfmt = { cmd = { "shfmt", "--filename", "$FILENAME" } }

M.formatters = {
    bash = shfmt,
    c = clang_format,
    cpp = clang_format,
    json = prettier,
    jsonc = prettier,
    lua = { cmd = { "stylua", "--stdin-filepath", "$FILENAME", "-" } },
    markdown = {
        cmd = {
            "markdownlint-cli2",
            "--config",
            (vim.env.XDG_CONFIG_HOME or vim.fn.expand("$HOME/.config"))
                .. "/markdownlint/config.yaml",
            "--fix",
            "$FILENAME",
        },
        -- It exits with 1 if there are issues that it can't fix.
        exit_codes = { 0, 1 },
        stdin = false,
    },
    python = {
        cmd = { "ruff", "format", "--stdin-filename", "$FILENAME", "-" },
    },
    sh = shfmt,
    toml = {
        cmd = { "taplo", "format", "--stdin-filepath", "$FILENAME", "-" },
    },
    yaml = prettier,
}

-- Returns the formatted lines, or nil if the formatter failed.
local function run(formatter, bufnr, lines)
    local path = vim.api.nvim_buf_get_name(bufnr)
    local file = path
    if formatter.stdin == false then
        file = vim.fn.tempname() .. "." .. vim.fn.fnamemodify(path, ":e")
        vim.fn.writefile(lines, file)
    end

    local cmd = vim.tbl_map(function(arg)
        return (arg:gsub("%$FILENAME", function()
            return file
        end))
    end, formatter.cmd)

    local cwd = vim.fn.fnamemodify(path, ":h")
    local result = vim.system(cmd, {
        cwd = vim.fn.isdirectory(cwd) == 1 and cwd or nil,
        stdin = formatter.stdin ~= false and table.concat(lines, "\n") .. "\n"
            or nil,
        text = true,
    }):wait()

    local output
    if vim.tbl_contains(formatter.exit_codes or { 0 }, result.code) then
        if formatter.stdin == false then
            output = vim.fn.readfile(file)
        else
            output = vim.split(result.stdout, "\n", { plain = true })
            if output[#output] == "" then
                table.remove(output)
            end
        end
    else
        local err = vim.trim(result.stderr ~= "" and result.stderr or result.stdout)
        vim.notify(
            ("%s failed:\n%s"):format(cmd[1], err),
            vim.log.levels.WARN
        )
    end

    if formatter.stdin == false then
        vim.fn.delete(file)
    end
    return output
end

-- Only replace the lines that changed, so that marks and the cursor stay put.
local function apply(bufnr, old, new)
    local hunks = vim.text.diff(
        table.concat(old, "\n") .. "\n",
        table.concat(new, "\n") .. "\n",
        { result_type = "indices" }
    )
    for i = #hunks, 1, -1 do
        local start_a, count_a, start_b, count_b = unpack(hunks[i])
        -- An insertion is reported after the line it follows.
        local first = count_a == 0 and start_a or start_a - 1
        vim.api.nvim_buf_set_lines(
            bufnr,
            first,
            first + count_a,
            false,
            vim.list_slice(new, start_b, start_b + count_b - 1)
        )
    end
end

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
    callback = function(args)
        local bufnr = args.buf
        if vim.b[bufnr].autoformat == false then
            return
        end

        local formatter = M.formatters[vim.bo[bufnr].filetype]
        if formatter and vim.fn.executable(formatter.cmd[1]) == 1 then
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local formatted = run(formatter, bufnr, lines)
            if formatted then
                apply(bufnr, lines, formatted)
            end
            return
        end

        -- No external formatter: try LSP
        for _, cl in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
            if cl:supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
                break
            end
        end
    end,
})

return M
