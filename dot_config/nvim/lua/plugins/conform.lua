vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim", version = "v9.1.0" },
}, { confirm = false })
require("conform").setup({
    formatters_by_ft = {
        bash = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        markdown = { "markdownlint-cli2" },
        python = { "ruff_format" },
        sh = { "shfmt" },
        toml = { "taplo" },
        yaml = { "prettier" },
    },
    formatters = {
        ["markdownlint-cli2"] = {
            prepend_args = {
                "--config",
                (vim.env.XDG_CONFIG_HOME or vim.fn.expand("$HOME/.config"))
                    .. "/markdownlint/config.yaml",
            },
        },
        taplo = {
            args = { "format", "--stdin-filepath", "$FILENAME", "-" },
        },
    },
    format_on_save = function(bufnr)
        if vim.b[bufnr].autoformat == false then
            return
        end
        return { lsp_format = "fallback" }
    end,
})
