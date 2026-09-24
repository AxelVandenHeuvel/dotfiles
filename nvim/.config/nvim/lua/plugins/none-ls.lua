return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
      },
    })
    -- none-ls owns formatting; language servers that can also format (lua_ls, ts_ls) are skipped
    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ filter = function(client) return client.name == "null-ls" end })
    end, {})
  end,
}
