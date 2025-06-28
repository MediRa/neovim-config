return {
    {
        "lewis6991/gitsigns.nvim",
        enabled = vim.fn.executable("git") == 1,
        opts = {
            worktrees = vim.g.git_worktrees,
        },
    },
    {
        "dinhhuy258/git.nvim",
        event = "BufReadpre",
        opts = {
            keymaps = {
                blame = "<leader>gb",
                browse = "<leader>gb",
            },
        },
    },
}
