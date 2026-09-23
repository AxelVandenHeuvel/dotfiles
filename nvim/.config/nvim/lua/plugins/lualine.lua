return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup({
      options = {
        theme = "gruvbox_light"
      }
    })
  end
}
