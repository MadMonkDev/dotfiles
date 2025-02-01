return{
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup{
      options = {
        mode = 'buffer',
        offsets = {
          filetype = 'NvimTree',
          text = "File Explorer",
          highlight = "Directory",
          seperator = true,
        }
      }
    }
  end;
  vim.keymap.set('n', '<leader>bl', ':BufferLinePick<CR>')
}
