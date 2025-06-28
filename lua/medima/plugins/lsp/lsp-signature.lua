return {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
        require("lsp_signature").setup({
            hi_parameter = "LspSignatureActiveParameter",
            bind = true, -- This is mandatory for the plugin to work
            doc_lines = 10, -- How many lines of documentation to show
            floating_window = true, -- Default is true, disable for virtual text
            virtual_text = true, -- Display as virtual text (less intrusive)
            max_width = 80, -- Max width of the floating window
            zindex = 200, -- Z-index for floating windows
            toggle_key = "<C-k>", -- Key to manually toggle the signature help
            select_signature_key = "<C-S-k>", -- Key to switch between overloaded signatures
            -- Other configuration options as per the plugin's documentation
        })
    end,
}
