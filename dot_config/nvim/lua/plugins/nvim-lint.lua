return {
    "mfussenegger/nvim-lint",
    opts = {
        linters = {
            ["markdownlint-cli2"] = {
                args = {
                    "--config",
                    (vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config"))
                        .. "/markdownlint/config.yaml",
                    "-",
                },
            },
        },
    },
}
