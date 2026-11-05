-- Python linting, quick fixes, and import sorting. Requires `ruff` on `PATH`
-- (installed with uv). Formatting on save uses `ruff format` directly.
return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { { "pyproject.toml", "ruff.toml", ".ruff.toml" }, ".git" },
}
