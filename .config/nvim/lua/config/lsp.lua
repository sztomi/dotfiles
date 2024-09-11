vim.g.coq_settings = {
    auto_start = "shut-up",
    ["keymap.recommended"] = true,
}

local lsp = require "lspconfig"
local coq = require "coq"

lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())

function _G.toggle_virtual_text()
    local current_value = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({
        virtual_text = not current_value,
        signs = true -- Keep signs enabled
    })
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
})

