if vim.env.SSH_TTY then
    local osc52 = require("vim.ui.clipboard.osc52")
    vim.g.clipboard = {
        name = "OSC 52",
        copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
        paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
    }
    vim.opt.clipboard = "unnamedplus"
elseif vim.env.TMUX then
    vim.g.clipboard = {
        name = "tmux",
        copy = {
            ["+"] = { "tmux", "load-buffer", "-w", "-" },
            ["*"] = { "tmux", "load-buffer", "-w", "-" },
        },
        paste = {
            ["+"] = { "tmux", "save-buffer", "-" },
            ["*"] = { "tmux", "save-buffer", "-" },
        },
        cache_enabled = 0,
    }
    vim.opt.clipboard = "unnamedplus"
end
