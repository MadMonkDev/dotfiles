return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "catppuccin",
            colorscheme = "catppuccin",
            after = [[vim.cmd.colorscheme = "catppuccin"]]
          },
          {
            name = "tokyonight",
            colorscheme = "tokyonight",
            after = [[vim.cmd.colorscheme = "tokyonight"]]
         },
        {
          name = "gruvbox",
          colorscheme = "gruvbox",
          after = [[vim.cmd.colorscheme = "gruvbox"]]
        }
        },
        livePreview = true;
      })
    end;
    "folke/tokyonight.nvim",
    "ellisonleao/gruvbox.nvim"
  }
