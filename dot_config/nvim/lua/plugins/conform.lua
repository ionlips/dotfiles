vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim", version = "v9.1.0" },
}, { confirm = false })

local function buffer_dir(_, ctx)
    return ctx.dirname
end

local function biome_indent(_, ctx)
    if vim.fs.root(ctx.dirname, { "biome.json", "biome.jsonc" }) then
        return {}
    end
    return { "--indent-style=space", "--indent-width=2" }
end

require("conform").setup({
    formatters_by_ft = {
        bash = { "shfmt" },
        c = { "clang-format" },
        cmake = { "gersemi" },
        cpp = { "clang-format" },
        cuda = { "clang-format" },
        json = { "biome" },
        jsonc = { "biome" },
        lua = { "stylua" },
        markdown = { "rumdl" },
        python = { "ruff_format" },
        sh = { "shfmt" },
        toml = { "taplo" },
        yaml = { "yamlfmt" },
    },
    formatters = {
        biome = {
            append_args = biome_indent,
        },
        rumdl = {
            command = "rumdl",
            args = { "fmt", "--silent", "--stdin-filename", "$FILENAME", "-" },
            stdin = true,
            cwd = buffer_dir,
        },
        taplo = {
            args = { "format", "--stdin-filepath", "$FILENAME", "-" },
        },
        yamlfmt = {
            cwd = buffer_dir,
        },
    },
    format_on_save = function(bufnr)
        if vim.b[bufnr].autoformat == false then
            return
        end
        return { lsp_format = "fallback" }
    end,
})
