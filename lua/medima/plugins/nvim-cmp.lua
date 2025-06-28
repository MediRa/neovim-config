return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "tailwind-tools",
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
        },
        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms
        {
            "roobert/tailwindcss-colorizer-cmp.nvim",
            config = true,
        },
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            -- add
            completion = {
                completeopt = "menu,menuone,noselect",
                keyword_length = 1,
                get_insert_text = function(entry)
                    if cmp.config.trigger_characters.has_char(entry:get_insert_text()) then
                        return entry:get_insert_text()
                    end
                    return vim.snippet.active and entry.completion_item.insertText or entry:get_insert_text()
                end,
            },

            -- -- Signature help specific settings for nvim-cmp
            -- sorting = cmp.config.sorting.by_priority,
            -- formatting = {
            --     fields = { "kind", "abbr", "menu" },
            --     format = function(entry, item)
            --         -- You can customize how items are displayed
            --         return item
            --     end,
            -- },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "buffer" }, -- text within current buffer
                { name = "path" }, -- file system paths
            }),

            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                    before = require("tailwind-tools").lspkind_format,
                }),
            },
            -- added
        })

        cmp.setup.filetype({ "sql" }, {
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
            },
        })
    end,
}
