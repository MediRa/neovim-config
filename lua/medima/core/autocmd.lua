-- basic autocommand
return {
    vim.api.nvim_create_autocmd("TextYankPost", {
        desc = "Highlight whne yanking (copying) text",
        callback = function()
            vim.highlight.on_yank()
        end,
    }),
}
