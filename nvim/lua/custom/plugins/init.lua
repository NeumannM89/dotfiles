-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
      'echasnovski/mini.pick', -- optional
    },
    config = true,

    vim.keymap.set('n', '<leader>gs', ':Neogit <CR>', { desc = '[g]it [s]tatus', silent = true, noremap = true }),
    vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', { desc = '[g]it [b]ranches', silent = true, noremap = true }),
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
  -- stylua: ignore
    keys = {
      { "<leader>jj", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "[J]ump" },
      { "<leader>jt", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "[J]ump Treesitter" },
      { "<leader>jr", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "<leader>jR", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<leader>jT>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'Civitasv/cmake-tools.nvim',
    opts = {},
  },
}
