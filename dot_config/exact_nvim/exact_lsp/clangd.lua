-- C and C++. Requires `clangd` on `PATH`, e.g. via `uv tool install clangd` or
-- `module load`. It needs `compile_commands.json` (or `compile_flags.txt`) to
-- know how the project is built, e.g. from `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`.
return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--header-insertion=iwyu",
    },
    filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
    -- The nearest build description, otherwise the repository. `.clang-format`
    -- isn't a marker, as `~/.clang-format` would make `$HOME` the root.
    root_markers = {
        { ".clangd", "compile_commands.json", "compile_flags.txt" },
        ".git",
    },
}
