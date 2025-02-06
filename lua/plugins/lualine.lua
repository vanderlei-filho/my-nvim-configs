return {
  -- Lualine statusline
  "nvim-lualine/lualine.nvim",
  dependencies = { "folke/tokyonight.nvim" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "tokyonight",
      },
    })
  end,
}
