-- Everything mason should install: language servers (enabled in lsp-config.lua) and formatters (used by none-ls.lua).
local ensure_installed = {
  "lua-language-server",
  "pyright",
  "typescript-language-server",
  "eslint-lsp",
  "stylua",
  "prettier",
  "black",
  "isort",
}

return {
  "mason-org/mason.nvim",
  config = function()
    require("mason").setup()
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(ensure_installed) do
        local pkg = registry.get_package(name)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end,
}
