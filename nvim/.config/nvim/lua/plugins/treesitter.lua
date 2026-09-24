return {

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({ "lua", "python", "javascript", "typescript", "json", "markdown" })

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- only take over indenting when a parser exists, so other filetypes keep their own indent rules
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
