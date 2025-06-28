return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        -- { "folke/neodev.nvim", opts = {} },
        { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import mason_lspconfig plugin
        local mason_lspconfig = require("mason-lspconfig")

        local mason_registry = require("mason-registry")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        -- local on_attach = function(client, bufnr),

        -- local util = require("lspconfig/util")
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        -- Original capabilities
        local capabilities = cmp_nvim_lsp.default_capabilities()
        -- local capabilities = blink_cmp.get_lsp_capabilities()

        -- addedlspc
        -- utils
        local util = require("lspconfig.util")

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            -- ["svelte"] = function()
            --     -- configure svelte server
            --     lspconfig["svelte"].setup({
            --         capabilities = capabilities,
            --         on_attach = function(client, bufnr)
            --             vim.api.nvim_create_autocmd("BufWritePost", {
            --                 pattern = { "*.js", "*.ts" },
            --                 callback = function(ctx)
            --                     -- Here use ctx.match instead of ctx.file
            --                     client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            --                 end,
            --             })
            --         end,
            --     })
            -- end,

            -- ["pyright"] = function()
            --     lspconfig["pyright"].setup({
            --
            --     })

            ["graphql"] = function()
                -- configure graphql language server
                lspconfig["graphql"].setup({
                    capabilities = capabilities,
                    filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
                })
            end,

            ["emmet_ls"] = function()
                -- configure emmet language server
                lspconfig["emmet_ls"].setup({
                    capabilities = capabilities,
                    filetypes = {
                        "html",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "svelte",
                    },
                    -- init_options = {
                    -- },
                    init_options = {
                        html = {
                            options = {
                                ["bem.enabled"] = true,
                            },
                        },
                        ---@type table<string, string>
                        includeLanguages = {},
                        --- @type string[]
                        excludeLanguages = {},
                        --- @type string[]
                        extensionsPath = {},
                        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                        preferences = {},
                        --- @type boolean Defaults to `true`
                        showAbbreviationSuggestions = true,
                        --- @type "always" | "never" Defaults to `"always"`
                        showExpandedAbbreviation = "always",
                        --- @type boolean Defaults to `false`
                        showSuggestionsAsSnippets = false,
                        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                        syntaxProfiles = {},
                        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                        variables = {},
                    },
                })
            end,

            ["jsonls"] = function()
                lspconfig["jsonls"].setup({
                    format = { enable = false },
                    settings = {
                        json = {
                            schemas = {
                                {
                                    description = "Eslint config",
                                    fileMatches = { ".eslintrc.json", ".eslintrc" },
                                    url = "https://json.schemastore.org/eslintrc",
                                },
                            },
                        },
                    },
                })
            end,

            -- Lua language
            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,

            -- My current lsp
            -- Vue js
            -- ["volar"] = function()
            --     lspconfig["volar"].setup({})
            -- end,

            -- ["volar"] = function()
            --     lspconfig["volar"].setup({
            --         capabilities = capabilities,
            --         on_attach = function(client, bufnr)
            --             vim.keymap.set("n", "gD", vim.lsp.buf.definition, { buffer = bufnr })
            --             vim.keymap.set("n", "gT", "<cmd>TSToolsGoToSourceDefinition<cr>", { buffer = bufnr })
            --         end,
            --         init_options = {
            --             typescript = {
            --                 tsdk = vim.fn.stdpath("data")
            --                     .. "/mason/packages/vue-language-server/node-modules/typescript",
            --             },
            --             vue = {
            --                 hybridMode = true,
            --             },
            --         },
            --         -- root_dir = util.root_pattern("src/App.vue"),
            --         -- settings = {
            --         --     typescript = {
            --         --         inlayHints = {
            --         --             enumMemberValues = { enabled = true },
            --         --             propertyDeclerationTypes = { enabled = true },
            --         --             parameterTypes = {
            --         --                 enabled = true,
            --         --                 supressWhenArgumentMatchesName = true,
            --         --             },
            --         --             variableTypes = { enabled = true },
            --         --         },
            --         --     },
            --         -- },
            --     })
            -- end,

            -- css
            ["cssls"] = function()
                lspconfig["cssls"].setup({
                    capabilities = capabilities,
                })
            end,
            --
            ["html"] = function()
                lspconfig["html"].setup({
                    capabilities = capabilities,
                })
            end,

            ["tailwindcss"] = function()
                lspconfig["tailwindcss"].setup({
                    capabilities = capabilities,
                    filetypes = {
                        "vue",
                        "html",
                        "templ",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "svelte",
                        "htmlangular",
                    },
                    init_options = {
                        userLanguages = {
                            vue = "html",
                            javascript = "javascript",
                            typescript = "typescript",
                        },
                    },
                    -- root_dir = util.root_pattern("src/*.vue"),
                    settings = {
                        tailwindCSS = {
                            experimental = {
                                classRegex = {
                                    { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                                    "tw`([^`]*)",
                                    'class:\\s*"([^"]*)',
                                },
                            },
                        },
                    },
                })
            end,
            -- typescript laguage server

            ["ts_ls"] = function()
                local vue_typescript_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
                    .. "/node_modules/@vue/language-server"

                -- local locations = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/@vue/language-server"

                lspconfig["ts_ls"].setup({
                    cmd = { "typescript-language-server", "--stdio" },
                    filetypes = {
                        "javascript",
                        -- "javascript.jsx",
                        "javascriptreact",
                        "typescript",
                        -- "typescript.tsx",
                        "typescriptreact",
                        "vue",
                    },
                    init_options = {
                        plugins = {
                            {
                                name = "@vue/typescript-plugin",
                                location = vue_typescript_server_path,
                                languages = {
                                    "vue",
                                    "javascript",
                                    "typescript",
                                },
                            },
                        },
                        hostInfo = "neovim",
                    },
                    single_file_support = false,
                    root_dir = util.root_pattern({
                        "package.json",
                        "tsconfig.json",
                        "jsconfig.json",
                        ".git",
                    }),
                    settings = {
                        typescript = {
                            -- tsserver = {
                            --     userSintaxServer = false,
                            -- },
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                                includeInlayPropertyDeclarationTypeHints = true,
                                includeInlayFunctionLikeReturnTypeHints = true,
                                includeInlayEnumMemberValueHints = true,
                            },
                            -- inlayHintss = {
                            --     includeInlayFunctionParameterNameHints = "all",
                            --     includeInlayFunctionParameterNameHintsWhenArgumentMatchesName = true,
                            --     includeInlayFunctionParameterTypeHints = true,
                            --     includeInlayVariableTypeHints = true,
                            --     includeInlayVariableTypeHintsWhenTypeMatches = true,
                            --     includeInlayPropertyDeclarationTypeHints = true,
                            --     includeInlayFunctionLikeReturnTypeHints = true,
                            --     includeInlayEnumMemberValueHints = true,
                            -- },
                        },
                    },
                })
            end,

            ["gopls"] = function()
                lspconfig["gopls"].setup({
                    capabilities = capabilities,
                    filetypes = {
                        "go",
                        "gowork",
                        "gomod",
                        "gotmpl",
                    },
                    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                    settings = {
                        gopls = {
                            staticcheck = true,
                            gofumpt = true,
                            codelenses = {
                                gc_details = false,
                                generate = true,
                                regenerate_cgo = true,
                                run_govulncheck = true,
                                test = true,
                                tidy = true,
                                upgrade_dependency = true,
                                vendor = true,
                            },
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                            -- analyses = {
                            --     fieldalignment = true,
                            --     nilness = true,
                            --     unusedparams = true,
                            --     unusedwrite = true,
                            --     useany = true,
                            -- },
                            usePlaceholders = false,
                            completeUnimported = true,
                            directoryFilters = {
                                "-.git",
                                "-.vscode",
                                "-.idea",
                                "-.vscode-test",
                                "-node_modules",
                                "-.nvim",
                            },
                            semanticTokens = true,
                        },
                    },
                })
            end,

            -- PHP language
            ["intelephense"] = function()
                lspconfig["intelephense"].setup({
                    capabilities = capabilities,
                    -- on_attach = on_attach,
                    settings = {
                        intelephense = {
                            stubs = {
                                "Core",
                                "Reflection",
                                "SPL",
                                "simpleXML",
                                "ctype",
                                "date",
                                "exif",
                                "filter",
                                "hash",
                                "imagick",
                                "json",
                                "psre",
                                "random",
                                "standard",
                                "dom",
                            },
                        },
                    },
                })
            end,

            -- ["rust_analyzer"] = function()
            --     lspconfig["rust_analyzer"].setup({
            --         capabilities = capabilities,
            --         filetypes = { "rust" },
            --         root_dir = util.root_pattern("cargo.toml"),
            --         settings = {
            --             ["rust_analyzer"] = {
            --                 diagnostics = {
            --                     enable = false,
            --                 },
            --                 cargo = {
            --                     allFeatures = true,
            --                     analysis = {
            --                         unusedparams = true,
            --                     },
            --                     staticcheck = true,
            --                 },
            --             },
            --         },
            --     })
            -- end,
        })
    end,
}
