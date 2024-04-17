return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    f = function() 
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end
    vim.keymap.set(
      'n',
      '<leader>e',
      ':Neotree toggle<CR>',
      {}
    )
    vim.keymap.set(
      'n',
      '<leader>o',
      f,
      {}
    )
  end
}
