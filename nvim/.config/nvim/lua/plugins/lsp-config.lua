return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  config = function()
    vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
    vim.lsp.enable({ 'lua_ls', 'pyright' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
  end,
}
