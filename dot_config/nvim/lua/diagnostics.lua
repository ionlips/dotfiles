vim.diagnostic.config({ virtual_text = true })

vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist)
