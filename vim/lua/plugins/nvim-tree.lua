return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },

    opts = {
      hijack_netrw = false,
      hijack_directories = {
        enable = false,
      }
    },

    keys = {
      { '<leader>nn', '<cmd>NvimTreeToggle<cr>' }
    }
  }
}
