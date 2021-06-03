return 0
local lsp = require'nvim_lsp'
lsp.rust_analyzer.setup{on_attach = on_attach}
lsp.tsserver.setup{on_attach = on_attach}
lsp.gdscript.setup{on_attach = on_attach}
lsp.ccls.setup{on_attach = on_attach}
lsp.pyls.setup{on_attach = on_attach}

local map = function(type, key, value)
    vim.fn.nvim_buf_set_keymap(0, type, key, value, {noremap = true,silent = true})
end

local on_attach = function(client)
    print("LSP Started")
    require'completion'.on_attach(client)

    map('n', '<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
    map('n', '<Leader>gt', '<cmd>lua vim.lsp.buf.definition()<CR>')
    map('n', '<Leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    map('n', '<Leader>fmt', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end
