return {
    { "mason-org/mason.nvim", version = "^1.0.0" },
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers(lsp) for mason to install
            ensure_installed = {
                "gopls", -- Golang language
                "intelephense", -- Php
                -- "volar", -- Vuejs
                "ts_ls", -- Typescript

                -- basic website
                "html", -- Html
                "cssls", -- Css
                "tailwindcss", -- Tailwindcss

                "lua_ls", -- Lua
                "graphql", -- Graphql
                "emmet_ls", -- entahlah
                "pyright", -- Python
                "jsonls", --
                "eslint",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "prettierd", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint",
                "eslint_d",
            },
        })
    end,
}
