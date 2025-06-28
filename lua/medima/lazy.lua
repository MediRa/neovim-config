local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "medima.plugins" },
    { import = "medima.plugins.lsp" },
    { import = "medima.plugins.ui" },
    { import = "medima.plugins.git" },
    { import = "medima.plugins.completion" },
}, {
    spec = {},
    -- install = {
    --     colorscheme = { "tokyonight", "everforest" },
    -- },
    -- newly added
    { import = "lazynvim.plugins.extras.linting.estlint" },
    { import = "lazynvim.plugins.extras.formatting.prittier" },
    { import = "lazynvim.plugins.extras.lang.javascript" },
    { import = "lazynvim.plugins.extras.lang.json" },
    { import = "lazynvim.plugins.extras.lang.tailwind" },
    { import = "lazynvim.plugins.extras.lang.rust" },

    checker = {
        enabled = true,
        notify = false,
    },

    change_detection = {
        notify = false,
    },
    ui = {
        border = "double",
        size = {
            width = 1,
            height = 1,
        },
    },
})
