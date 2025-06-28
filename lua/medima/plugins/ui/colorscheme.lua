return {
    {
        "folke/tokyonight.nvim",
    },
    {
        "Shatur/neovim-ayu",
    },
    {
        "yorumicolors/yorumi.nvim",
    },
    {
        "bluz71/vim-nightfly-guicolors",
        -- priority = 1000,
        name = "nightfly",
        lazy = false,
        config = function()
            vim.g.nightflyNormalFloat = true
            vim.g.nightflyItalics = true
            vim.g.nightflyCursors = true
            vim.g.nightflyWinSeparator = 2
            -- vim.cmd("colorscheme nightfly")
        end,
    },
    {
        "sainnhe/everforest",
        config = function()
            vim.g.everforest_enable_italic = true
            vim.g.everforest_background = "hard"
            vim.cmd("colorscheme everforest")
        end,
    },

    {
        "folke/tokyonight.nvim",
        -- priority = 1000, -- Set this theme as top priority if enable
        config = function()
            local transparent = false -- set to true if you would like to enable transparency

            -- local bg = "#011628"
            -- local bg_dark = "#011423"
            -- local bg_highlight = "#143652"
            -- local bg_search = "#0A64AC"
            -- local bg_visual = "#275378"
            -- local fg = "#CBE0F0"
            -- local fg_dark = "#B4D0E9"
            -- local fg_gutter = "#627E97"
            -- local border = "#547998"
            --
            -- require("tokyonight").setup({
            --     style = "night",
            --     transparent = transparent,
            --     styles = {
            --         sidebars = transparent and "transparent" or "dark",
            --         floats = transparent and "transparent" or "dark",
            --     },
            --     on_colors = function(colors)
            --         colors.bg = bg
            --         colors.bg_dark = transparent and colors.none or bg_dark
            --         colors.bg_float = transparent and colors.none or bg_dark
            --         colors.bg_highlight = bg_highlight
            --         colors.bg_popup = bg_dark
            --         colors.bg_search = bg_search
            --         colors.bg_sidebar = transparent and colors.none or bg_dark
            --         colors.bg_statusline = transparent and colors.none or bg_dark
            --         colors.bg_visual = bg_visual
            --         colors.border = border
            --         colors.fg = fg
            --         colors.fg_dark = fg_dark
            --         colors.fg_float = fg
            --         colors.fg_gutter = fg_gutter
            --         colors.fg_sidebar = fg_dark
            --     end,
            -- })
            -- vim.cmd("colorscheme tokyonight")
        end,
    },
}
